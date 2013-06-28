require_relative 'url_shortener'

class TweetText
  def self.from_link link
    url = UrlShortener.shorten link.url
    text = link.title[0,(140 - (url.size + 1))]
    "%s %s" % [text, url]
  end
end
