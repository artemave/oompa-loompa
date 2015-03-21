require 'googl'

class UrlShortener
  def self.shorten url
    server_ip      = ENV.fetch "GOOGLE_ALLOWED_IP"
    google_api_key = ENV.fetch "GOOGLE_API_KEY"

    Googl.shorten(url, server_ip, google_api_key).short_url
  end
end
