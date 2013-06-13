require_relative 'twitter'

class AccountStatusUpdater

  def initialize account
    @account = account
  end

  def maybe_tweet_the_link link
    return if score_too_low?(link)
    return if source_does_not_match?(link)
    return if already_tweeted?(link)

    Twitter.tweet @account, link
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
