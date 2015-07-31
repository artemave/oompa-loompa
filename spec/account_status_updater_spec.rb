require_relative '../lib/models/account.rb'
require_relative '../lib/models/link.rb'
require_relative '../lib/models/tweet.rb'
require_relative '../lib/account_status_updater.rb'
require_relative 'spec_helper'

describe AccountStatusUpdater do
  let(:account) do
    Account.create(username: 'Hn150')
  end
  let(:link) do
    Link.new source: 'Hn',
      score: 200,
      title: 'beer is good',
      comments_url: 'http://beer_is_good.com/comments',
      url: 'http://beer_is_good.com'
  end
  let(:shitty_link) do
    Link.new source: 'Hn',
      score: 20,
      title: 'beer is bad',
      comments_url: 'http://beer_is_good.com/comments',
      url: 'http://beer_is_bad.com'
  end

  let(:tweet_text) { class_double('TweetText').as_stubbed_const }
  let(:twitter_class) { class_double('TwitterAdapter').as_stubbed_const }
  let(:twitter) { instance_double 'TwitterAdapter' }

  before :each do
    allow(twitter_class).to receive(:new).with(account).and_return(twitter)
    allow(tweet_text).to receive(:from_link).with(link).and_return('text')
  end

  subject { AccountStatusUpdater.new account }

  context "Link source matches account" do
    context "Link score is greater than account minimum acceptable score" do
      context "Link has not been tweeted yet" do
        before do
          allow(twitter).to receive(:tweet)
        end

        it "tweets the link" do
          expect(twitter).to receive(:tweet).with('text')
          subject.maybe_tweet_the_links([link, shitty_link])
        end

        it "adds tweet to account's sent tweets" do
          subject.maybe_tweet_the_links([link, shitty_link])

          expect(account.tweets.count).to eq(1)
          expect(account.tweets.last.link_url).to eq(link.url)
        end
      end

      context "Link has already been tweeted" do
        it "does not tweet the link" do
          allow(account).to receive(:tweets).and_return([Tweet.new(link_url: 'http://beer_is_good.com')])

          expect(twitter).not_to receive(:tweet)
          subject.maybe_tweet_the_links([link])
        end
      end
    end

    context "Link score is lower than account minimum acceptable score" do
      it "does not tweet the link" do
        allow(link).to receive(:score).and_return(100)

        expect(twitter).not_to receive(:tweet)
        subject.maybe_tweet_the_links([link])
      end
    end
  end

  context "Link source does not match account" do
    it "does not tweet the link" do
      allow(link).to receive(:source).and_return('RProgramming')

      expect(twitter).not_to receive(:tweet)
      subject.maybe_tweet_the_links([link])
    end
  end
end
