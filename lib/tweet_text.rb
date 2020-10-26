class TweetText
  def self.from_link link
    # 23 is Twitter url character size
    max_title_size = 280 - 1 - 23 - 1 - 1 - 23 - 2
    ddd = link.title.size > max_title_size + 3 ? '...' : ''

    text = link.title[0, (max_title_size - ddd.size)]
    "%s%s %s (%s)" % [text, ddd, link.url, link.comments_url]
  end
end
