require_relative 'spec_helper'
require_relative '../lib/good_to_tweet_check'

describe GoodToTweetCheck do
  let(:account) do
    Account.new(username: 'HN150')
  end
  let(:link) do
    Link.new source: 'HN',
      score: 200,
      name: 'beer is good',
      url: 'http://beer_is_good.com'
  end

  context "Link source matches account" do
    context "Link score is greater than account minimum acceptable score" do
      context "Link has not been tweeted yet" do
        it "returns true" do
          GoodToTweetCheck.perform(account, link).should == true
        end
      end

      context "Link has already been tweeted" do
        it "returns false" do
          account.stub(:tweeted_links).and_return([link])
          GoodToTweetCheck.perform(account, link).should == false
        end
      end
    end

    context "Link score is lower than account minimum acceptable score" do
      it "returns false" do
        link.stub(:score).and_return(100)
        GoodToTweetCheck.perform(account, link).should == false
      end
    end
  end

  context "Link source does not match account" do
    it "returns false" do
      link.stub(:source).and_return('Proggit')
      GoodToTweetCheck.perform(account, link).should == false
    end
  end
end
