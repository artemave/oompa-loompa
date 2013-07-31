require_relative 'url_shortener'

class TweetText
  def self.from_link link
    url = UrlShortener.shorten link.url
    comments_url = UrlShortener.shorten link.comments_url

    max_title_size = 136 - (url.size + 1) - (comments_url.size + 3)
    dot_dot_dot = link.title.size > max_title_size ? '...' : ''

    text = link.title[0, (max_title_size - dot_dot_dot.size)]
    "%s%s %s (%s)" % [text, dot_dot_dot, url, comments_url]
  end
end
