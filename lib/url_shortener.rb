require 'googl'

class UrlShortener
  def self.shorten url
    Googl.shorten(url).short_url
  end
end
