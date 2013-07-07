require_relative 'lib/boot.rb'
require_relative 'lib/account_status_updater.rb'
require_relative 'lib/links.rb'
require_relative 'lib/models/account'

desc "Send tweets"
task :send_tweets do
  links = Links.fetch

  Account.all.each do |account|
    updater = AccountStatusUpdater.new(account)
    updater.maybe_tweet_the_links links
  end
end
