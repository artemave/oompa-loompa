# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "#{File.expand_path '../..', __FILE__}/log/cron_log.log"

every 10.minutes do
  command "cd #{File.expand_path '../..', __FILE__} && RACK_ENV=#@environment bundle exec rake send_tweets"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
