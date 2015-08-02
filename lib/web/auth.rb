require 'sinatra/base'
require 'omniauth-twitter'
require 'webrick'
require_relative '../boot'
require_relative '../models/account'

$production = ENV['RACK_ENV'] == 'production'

class TwitterAuth < Sinatra::Base
  if $production
    require 'rack/ssl'
    use Rack::SSL
  end

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
end

CERT_PATH = File.expand_path '../../../config', __FILE__

common_webrick_options = {
  :Port => ENV.fetch('PORT', 4567),
}

webrick_options = if $production
  require 'webrick/https'
  require 'openssl'

  common_webrick_options.merge(
    :SSLEnable       => true,
    :SSLVerifyClient => OpenSSL::SSL::VERIFY_NONE,
    :SSLCertificate  => OpenSSL::X509::Certificate.new(File.open(File.join(CERT_PATH, "server.crt")).read),
    :SSLPrivateKey   => OpenSSL::PKey::RSA.new(        File.open(File.join(CERT_PATH, "server.key")).read),
    :SSLCertName     => [ [ "CN",WEBrick::Utils::getservername ] ]
  )
else
  common_webrick_options
end

Rack::Handler::WEBrick.run TwitterAuth, webrick_options
