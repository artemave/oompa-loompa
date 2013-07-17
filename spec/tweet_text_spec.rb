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
    url_shortener.stub(:shorten).and_return('stub')
  end

  it "makes sure text does not exceed 140 characters" do
    link.title = 'b'*200
    msg = TweetText.from_link link

    msg.size.should == 140
  end

  context "link is too long" do
    before :each do
      link.title = 'b'*200
    end

    it "makes sure text does not exceed 140 characters" do
      msg = TweetText.from_link link
      msg.size.should == 140
    end

    it "includes shortened link nontheless" do
      url_shortener.stub(:shorten).with('http://long.url.com/aaa/bbb').and_return('aaa')
      msg = TweetText.from_link link
      msg.should =~ / aaa/
    end

    it "includes shortened comments link nontheless" do
      url_shortener.stub(:shorten).with('http://long.url.com/comments').and_return('comments')
      msg = TweetText.from_link link
      msg.should =~ / \(comments\)/
    end
  end

  it "shortens link url" do
    url_shortener.should_receive(:shorten).with('http://long.url.com/aaa/bbb').and_return('short_url')
    msg = TweetText.from_link link
    msg.should =~ / short_url/
  end

  it "shortens comments url" do
    url_shortener.should_receive(:shorten).with('http://long.url.com/comments').and_return('comments url')
    msg = TweetText.from_link link
    msg.should =~ / \(comments url\)/
  end
end
