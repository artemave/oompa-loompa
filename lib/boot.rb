require 'mongoid'
require_relative 'core_ext/string'

Mongoid.load!(File.expand_path '../../config/mongoid.yml', __FILE__)
