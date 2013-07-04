require 'ruby-hackernews'
require_relative '../models/link'

class Hn
  def self.fetch
    RubyHackernews::Entry.all.map do |entry|
      Link.new(
        score: entry.voting.score,
        title: entry.link.title,
        url: entry.link.href,
        source: to_s
      )
    end
  end
end
