require_relative '../boot.rb'
require_relative '../account_status_updater.rb'
require_relative '../links.rb'

desc "Send tweets"
task :send_tweets do
  links = Links.fetch

  Account.all.each do |account|
    updater = AccountStatusUpdater.new(account)
    links.each do |link|
      updater.maybe_tweet_the_link(link)
    end
  end
end
