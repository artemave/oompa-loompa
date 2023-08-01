require 'sinatra/base'
require 'omniauth'
require 'omniauth-twitter'
require_relative '../models/account'

class Site < Sinatra::Base
  set :sessions, true

  use OmniAuth::Builder do
    provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET'],
      scope: 'offline.access,tweet.write,tweet.read,users.read',
      use_authorize: true
  end

  get '/' do
    <<-HTML
      <form method='post' action='/auth/twitter'>
        <input type="hidden" name="authenticity_token" value='#{request.env["rack.session"]["csrf"]}'>
        <button type='submit'>Login with Twitter</button>
      </form>
    HTML
  end

  get '/auth/:name/callback' do
    auth_hash     = request.env['omniauth.auth']
    username      = auth_hash['info']['nickname']
    access_token  = auth_hash['credentials']['token']
    access_secret = auth_hash['credentials']['secret']

    if account = Account.where(username: username).first
      account[:access_token]  = access_token
      account[:access_secret] = access_secret
      account.save
    else
      Account.create username: username,
        access_token: access_token,
        access_secret: access_secret
    end

    'Success!'
  end
end
