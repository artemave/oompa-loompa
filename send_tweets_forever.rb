require 'rake'

Rake.load_rakefile 'Rakefile'

while true
  begin
    Rake.application[:send_tweets].invoke
  rescue StandardError => e
    puts e
    e.backtrace.each &method(:puts)
  end
  sleep 10.minutes
end
