require_relative 'url_shortener'

class TweetText
  def self.from_link link
    url = UrlShortener.shorten link.url
    comments_url = UrlShortener.shorten link.comments_url

    text = link.title[0,(140 - (url.size + 1) - (comments_url.size + 3))]
    "%s %s (%s)" % [text, url, comments_url]
  end
end
