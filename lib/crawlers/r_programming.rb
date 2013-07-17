require 'rest-client'
require 'json'
require_relative '../models/link'

class RProgramming
  def self.fetch
    data = RestClient.get 'http://www.reddit.com/r/programming/hot.json?sort=hot'
    json = JSON.load data

    json['data']['children'].map do |entry|
      Link.new(
        score: entry['data']['score'],
        title: entry['data']['title'],
        url: entry['data']['url'],
        comments_url: "http://www.reddit.com/#{entry['data']['permalink']}",
        source: to_s
      )
    end
  end
end
