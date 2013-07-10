require 'bundler'
Bundler.require

require 'mongoid'
require 'logger'

$logger = Logger.new STDOUT
Mongoid.load!(File.expand_path '../../config/mongoid.yml', __FILE__)
