require 'twitter'

class TwitterAdapter
  def initialize account
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = account.access_token
      config.access_token_secret = account.access_secret
    end
  end

  def tweet msg
    @client.update msg
  end
end
