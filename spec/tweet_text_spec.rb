require_relative 'spec_helper'
require_relative '../lib/tweet_text'

describe TweetText do
  let(:link) do
    Link.new(
      score: 23,
      title: 'this is title',
      url: 'http://long.url.com/aaa/bbb',
      comments_url: 'http://long.url.com/comments',
      source: 'Hn'
    )
  end

  let(:url_shortener) { class_double('UrlShortener').as_stubbed_const }
  before :each do
    allow(url_shortener).to receive(:shorten).and_return('stub')
  end

  context "link is too long" do
    before :each do
      link.title = 'b'*200
    end

    it "makes sure text does not exceed 140 characters (urls are always 23ch long)" do
      allow(url_shortener).to receive(:shorten).and_return('')
      msg = TweetText.from_link link
      expect(msg.size).to eq(140 - 2*23)
    end

    it "includes shortened link nontheless" do
      allow(url_shortener).to receive(:shorten).with('http://long.url.com/aaa/bbb').and_return('aaa')
      msg = TweetText.from_link link
      expect(msg).to match(/ aaa/)
    end

    it "follows cut title with ..." do
      msg = TweetText.from_link link
      expect(msg).to match(/bbb\.\.\. /)
    end

    it "includes shortened comments link nontheless" do
      allow(url_shortener).to receive(:shorten).with('http://long.url.com/comments').and_return('comments')
      msg = TweetText.from_link link
      expect(msg).to match(/ \(comments\)/)
    end
  end

  it "does not add ... if link.title is short enough" do
    msg = TweetText.from_link link
    expect(msg).not_to match(/\.\.\./)
  end

  it "shortens link url" do
    expect(url_shortener).to receive(:shorten).with('http://long.url.com/aaa/bbb').and_return('short_url')
    msg = TweetText.from_link link
    expect(msg).to match(/ short_url/)
  end

  it "shortens comments url" do
    expect(url_shortener).to receive(:shorten).with('http://long.url.com/comments').and_return('comments url')
    msg = TweetText.from_link link
    expect(msg).to match(/ \(comments url\)/)
  end
end
