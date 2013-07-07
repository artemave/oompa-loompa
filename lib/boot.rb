require 'mongoid'
require 'logger'
require_relative 'core_ext/string'

$logger = Logger.new STDOUT
Mongoid.load!(File.expand_path '../../config/mongoid.yml', __FILE__)
