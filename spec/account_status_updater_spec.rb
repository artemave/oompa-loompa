require_relative '../lib/models/account.rb'
require_relative '../lib/models/link.rb'
require_relative '../lib/models/tweet.rb'
require_relative '../lib/account_status_updater.rb'
require_relative 'spec_helper'

describe AccountStatusUpdater do
  let(:account) do
    Account.create(username: 'HN150')
  end
  let(:link) do
    Link.new source: 'HN',
      score: 200,
      title: 'beer is good',
      url: 'http://beer_is_good.com'
  end

  let(:tweet_text) { class_double('TweetText').as_stubbed_const }
  let(:twitter_class) {class_double('Twitter').as_stubbed_const}
  let(:twitter) { instance_double 'Twitter' }

  before :each do
    twitter_class.stub(:new).with(account).and_return(twitter)
    tweet_text.stub(:from_link).with(link).and_return('text')
  end

  subject { AccountStatusUpdater.new account }

  context "Link source matches account" do
    context "Link score is greater than account minimum acceptable score" do
      context "Link has not been tweeted yet" do
        it "tweets the link" do
          twitter.should_receive(:tweet).with('text')
          subject.maybe_tweet_the_link(link)
        end
      end

      context "Link has already been tweeted" do
        it "does not tweet the link" do
          account.stub(:tweets).and_return([Tweet.new(link_url: 'http://beer_is_good.com')])

          twitter.should_not_receive(:tweet)
          subject.maybe_tweet_the_link(link)
        end
      end
    end

    context "Link score is lower than account minimum acceptable score" do
      it "does not tweet the link" do
        link.stub(:score).and_return(100)

        twitter.should_not_receive(:tweet)
        subject.maybe_tweet_the_link(link)
      end
    end
  end

  context "Link source does not match account" do
    it "does not tweet the link" do
      link.stub(:source).and_return('Proggit')

      twitter.should_not_receive(:tweet)
      subject.maybe_tweet_the_link(link)
    end
  end
end
