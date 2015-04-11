require 'curb'
require 'tempfile'

class Twitter
  def initialize account
    @account = account
    @curb = Curl::Easy.new do |curl|
      curl.headers["User-Agent"] = "Mozilla/5.0"
      curl.enable_cookies = true
      curl.cookiejar = Tempfile.new('oompa_cookie').path
      curl.follow_location = true
    end
  end

  def login
    login_token = get_token("https://mobile.twitter.com/session/new")

    $logger.debug "login token: #{login_token}"

    @curb.url = 'https://mobile.twitter.com/session'
    post_fields = [
      Curl::PostField.content("authenticity_token", login_token),
      Curl::PostField.content("username", @account.username),
      Curl::PostField.content("password", @account.password)
    ]
    @curb.http_post post_fields

    $logger.debug @curb.status

    @logged_in = true
  end

  def tweet msg
    login unless @logged_in

    compose_tweet_token = get_token('https://mobile.twitter.com/compose/tweet')

    $logger.debug "compose_tweet_token: #{compose_tweet_token}"

    $logger.debug "Sending tweet"

    @curb.url = 'https://mobile.twitter.com/api/tweet'
    post_fields = [
      Curl::PostField.content("m5_csrf_tkn", compose_tweet_token),
      Curl::PostField.content("tweet[text]", msg)
    ]
    @curb.http_post post_fields

    if @curb.status =~ /^200/
      $logger.debug @curb.status
    else
      $logger.error @curb.status
    end
  end

  def logout
    @curb.url = "http://mobile.twitter.com/session/destroy"
    @curb.delete = true
    @curb.perform
  end

  private

  def get_token url
    @curb.url = url
    @curb.get
    content = @curb.body_str
    content[/authenticity_token.*?value="([^"]*)"/m, 1]
  end
end
