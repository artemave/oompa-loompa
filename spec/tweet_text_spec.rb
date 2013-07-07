require_relative 'spec_helper'
require_relative '../lib/tweet_text'

describe TweetText do
  let(:link) do
    Link.new(
      score: 23,
      title: 'this is title',
      url: 'http://long.url.com/aaa/bbb',
      source: 'Hn'
    )
  end

  let(:url_shortener) { class_double('UrlShortener').as_stubbed_const }

  it "makes sure text does not exceed 140 characters" do
    url_shortener.stub(:shorten).with('http://long.url.com/aaa/bbb').and_return('aaa')
    link.title = 'b'*200
    msg = TweetText.from_link link

    msg.size.should == 140
    msg.should =~ / aaa$/
  end

  it "shortens link url" do
    url_shortener.should_receive(:shorten).with('http://long.url.com/aaa/bbb').and_return('short_url')
    msg = TweetText.from_link link
    msg.should =~ /short_url/
  end
end
