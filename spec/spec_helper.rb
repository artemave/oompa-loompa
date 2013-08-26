Bundler.require :default, :test

ENV["RACK_ENV"] = 'test'
require_relative '../lib/boot.rb'

RSpec.configure do |config|
  config.include(RSpec::Fire)

  config.before(:each) do
    Mongoid::Sessions.default.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end
