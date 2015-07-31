require 'sinatra'
require 'omniauth-twitter'
require_relative '../boot'
require_relative '../models/account'

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'],
    x_auth_access_type: 'write',
    use_authorize: true
end

get '/' do
  <<-HTML
  <a href="/auth/twitter">Authorize account</a>
  HTML
end

get '/auth/twitter/callback' do
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
end
