require 'rest-client'

class TwitterAdapter
  def initialize account
    @client = RestClient::Resource.new(
      'https://api.twitter.com/2/tweets',
      headers: {
      }
    )

      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = account.access_token
      config.access_token_secret = account.access_secret
    end
  end

  def tweet msg
    @client.post msg
  end
end
