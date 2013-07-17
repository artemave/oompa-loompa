ENV['RACK_ENV'] = 'development'

require_relative '../lib/boot'
require_relative '../lib/twitter'
require_relative '../lib/models/account'
require_relative '../lib/models/link'
require_relative '../lib/tweet_text'

class TestScenario
  attr_accessor :account, :twitter, :link

  def initialize
    @account = Account.where(username: 'RProgramming200', password: "rlOXPv85l65I").first
    @account ||= Account.create(username: 'RProgramming200', password: "rlOXPv85l65I")

    @twitter = Twitter.new account
    @link    = Link.new title: 'test tweet', url: 'http://www.google.com', comments_url: 'http://www.google.com/comments'
  end

  def tweet
    twitter.tweet TweetText.from_link(link)
  end
end

#twitter.tweet link
