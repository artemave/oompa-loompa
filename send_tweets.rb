# to see stdout in docker logs
STDOUT.sync = true
STDERR.sync = true

require 'rake'

Rake.load_rakefile 'Rakefile'

begin
  Rake.application[:send_tweets].execute
rescue StandardError => e
  $logger.error e
  e.backtrace.each &$logger.method(:error)
end
