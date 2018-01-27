Bundler.require :default, :test

ENV["RACK_ENV"] = 'test'
require_relative '../lib/boot.rb'
require_relative '../lib/site.rb'
require_relative '../lib/models/account'

require 'capybara/cucumber'
require 'database_cleaner'
require 'database_cleaner/cucumber'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.app = Site

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean_with(:truncation)

Around do |scenario, block|
  DatabaseCleaner.cleaning(&block)
end
