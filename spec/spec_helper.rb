ENV["RACK_ENV"] = 'test'
require_relative '../lib/boot.rb'
require 'rspec/its'
require 'database_cleaner-mongoid'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
