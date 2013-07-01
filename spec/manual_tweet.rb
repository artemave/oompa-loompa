ENV['RACK_ENV'] = 'development'

require_relative '../lib/boot'
require_relative '../lib/twitter'
require_relative '../lib/models/account'
require_relative '../lib/models/link'

class TestScenario
  attr_accessor :account, :twitter, :link

  def initialize
    @account = Account.create username: 'HN150Proggit100', password: "G4ewzgNh2FgK"
    @twitter = Twitter.new account
    @link    = Link.new title: 'test tweet', url: 'http://www.google.com'
  end

  def tweet
    twitter.tweet link
  end
end

#twitter.tweet link
