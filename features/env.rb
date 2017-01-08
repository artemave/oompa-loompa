Bundler.require :default, :test

ENV["RACK_ENV"] = 'test'
require_relative '../lib/boot.rb'
require_relative '../lib/site.rb'
require_relative '../lib/models/account'

require 'capybara/cucumber'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.app = Site

Before do
  Mongoid::Sessions.default.collections.select {|c| c.name !~ /system/ }.each(&:drop)
end
