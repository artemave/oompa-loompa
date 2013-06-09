require_relative '../lib/account_status_updater.rb'
require_relative 'spec_helper'

describe AccountStatusUpdater do
  let(:link) {double :link}
  let(:account) {double :account}

  let(:good_to_tweet_check) {fire_replaced_class_double 'GoodToTweetCheck'}
  let(:twitter) {fire_replaced_class_double 'Twitter'}

  subject { AccountStatusUpdater.new account }

  context "link is NOT good enough to tweet" do
    before do
      good_to_tweet_check.stub(:perform).with(account, link).and_return(false)
    end

    it "does not tweet the link" do
      twitter.should_not_receive(:tweet)
      subject.maybe_tweet_the_link(link)
    end
  end

  context "link is good to tweet" do
    before do
      good_to_tweet_check.stub(:perform).with(account, link).and_return(true)
    end

    it "tweets the link" do
      twitter.should_receive(:tweet).with(account, link)
      subject.maybe_tweet_the_link(link)
    end
  end
end
