require 'rest-client'
require 'json'

class Proggit
  def self.fetch
    data = RestClient.get 'http://www.reddit.com/r/programming/hot.json?sort=hot'
    json = JSON.load data

    res['data']['children'].map do |entry|
      Link.new(
        score: entry['data']['score'],
        title: entry['data']['title'],
        url: entry['data']['url'],
        source: 'Proggit'
      )
    end
  end
end
