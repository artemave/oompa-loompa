require 'bundler'
Bundler.require :default

require 'mongoid'
require 'logger'

$logger = Logger.new STDOUT
$logger.level = Logger::INFO
$logger.formatter = proc do |severity, datetime, progname, msg|
  "#{severity} [#{datetime}]: #{msg}\n"
end

Mongoid.load!(File.expand_path '../../config/mongoid.yml', __FILE__)
Mongoid.logger = $logger
