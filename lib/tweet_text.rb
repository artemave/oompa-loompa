require_relative 'url_shortener'

class TweetText
  def self.from_link link
    url = UrlShortener.shorten link.url
    comments_url = UrlShortener.shorten link.comments_url

    # TODO fetch short url size from twitter api
    max_title_size = 140 - 1 - 23 - 1 - 1 - 23 - 1
    dot_dot_dot = link.title.size > max_title_size + 3 ? '...' : ''

    text = link.title[0, (max_title_size - dot_dot_dot.size)]
    "%s%s %s (%s)" % [text, dot_dot_dot, url, comments_url]
  end
end
