require 'bundler/setup'
require 'mongoid'
require 'logger'

$logger = Logger.new STDOUT
$logger.level = ENV["DEBUG"].present? ? Logger::DEBUG : Logger::INFO
$logger.formatter = proc do |severity, datetime, progname, msg|
  "#{severity} [#{datetime}]: #{msg}\n"
end

Mongoid.load!(File.expand_path '../../config/mongoid.yml', __FILE__)
Mongoid.logger = $logger
