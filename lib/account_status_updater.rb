require_relative 'twitter'
require_relative 'tweet_text'

class AccountStatusUpdater

  def initialize account
    @account = account
    @twitter = Twitter.new account
  end

  def maybe_tweet_the_links links
    links.each do |link|
      next if score_too_low?(link)
      next if source_does_not_match?(link)
      next if already_tweeted?(link)

      $logger.info "about to tweet #{link}"

      msg = TweetText.from_link(link)
      @twitter.tweet msg

      @account.tweets.create(link_url: link.url)
    end
  end

  private

  def already_tweeted? link
    @account.tweets.any? do |tweet|
      tweet.link_url == link.url
    end
  end

  def score_too_low? link
    link.score < @account.minimum_acceptable_score
  end

  def source_does_not_match? link
    link.source != @account.source
  end
end
