# to see stdout in docker logs
STDOUT.sync = true

require 'rake'

Rake.load_rakefile 'Rakefile'

puts "Starting up a daemon"

while true
  begin
    Rake.application[:send_tweets].invoke
  rescue StandardError => e
    puts e
    e.backtrace.each &method(:puts)
  end
  sleep 600
end
