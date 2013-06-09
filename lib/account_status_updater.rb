require_relative 'twitter'
require_relative 'good_to_tweet_check'

class AccountStatusUpdater

  def initialize account
    @account = account
  end

  def maybe_tweet_the_link link
    if GoodToTweetCheck.perform @account, link
      Twitter.tweet @account, link
    end
  end
end
