# to see stdout in docker logs
STDOUT.sync = true

require 'rake'

Rake.load_rakefile 'Rakefile'

$logger.info "Starting up a daemon"

while true
  begin
    Rake.application[:send_tweets].invoke
  rescue StandardError => e
    $logger.error e
    e.backtrace.each &$logger.method(:error)
  end
end
