require 'curb'

class Twitter
  def initialize account
    @account = account
    @curb = Curl::Easy.new do |curl|
      curl.headers["User-Agent"] = "Mozilla/5.0"
      curl.enable_cookies = true
      curl.follow_location = true
    end
  end

  def tweet msg
    login
    send_tweet msg
    logout
  end

  private

  def login
    login_token = get_token("https://mobile.twitter.com/session/new")

    @curb.url = 'https://mobile.twitter.com/session'
    post_fields = [
      Curl::PostField.content("authenticity_token", login_token),
      Curl::PostField.content("username", @account.username),
      Curl::PostField.content("password", @account.password)
    ]
    @curb.http_post post_fields
  end

  def send_tweet msg
    homepage_token = get_token("http://mobile.twitter.com/")

    @curb.url = 'https://mobile.twitter.com/'
    post_fields = [
      Curl::PostField.content("authenticity_token", homepage_token),
      Curl::PostField.content("tweet[text]", msg),
      Curl::PostField.content("tweet[display_coordinates]", 'false')
    ]
    @curb.http_post post_fields
  end

  def logout
    @curb.url = "http://mobile.twitter.com/session/destroy"
    @curb.perform
  end

  def get_token url
    @curb.url = url
    @curb.perform
    content = @curb.body_str
    content[/authenticity_token.*?value="([^"]*)"/m, 1]
  end
end
