# to see stdout in docker logs
STDOUT.sync = true

require 'rake'

Rake.load_rakefile 'Rakefile'

$logger.info "Starting up a daemon"

loop do
  begin
    Rake.application[:send_tweets].execute
  rescue StandardError => e
    $logger.error e
    e.backtrace.each &$logger.method(:error)
  end
  sleep 10.minutes
end
