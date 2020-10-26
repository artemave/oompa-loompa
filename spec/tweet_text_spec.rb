require_relative 'spec_helper'
require_relative '../lib/tweet_text'
require_relative '../lib/models/link'

describe TweetText do
  let(:link) do
    Link.new(
      score: 23,
      title: 'this is title',
      url: 'u' * 23,
      comments_url: 'c' * 23,
      source: 'Hn'
    )
  end

  context "title is too long" do
    before :each do
      link.title = 'b'*300
    end

    it "makes sure text does not exceed 280 characters (urls are always 23ch long)" do
      msg = TweetText.from_link link
      expect(msg.size).to eq(279)
    end

    it "follows cut title with ..." do
      msg = TweetText.from_link link
      expect(msg).to match(/bbb\.\.\. /)
    end
  end

  it "does not add ... if link.title is short enough" do
    msg = TweetText.from_link link
    expect(msg).not_to match(/\.\.\./)
  end
end
