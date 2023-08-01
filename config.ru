ENV['RACK_ENV'] ||= 'development'

require_relative './lib/boot'
require_relative './lib/web/site'
require 'awesome_print'

Site.routes.map do |method, routes|
  routes.map { |r| r.first.to_s }.map do |route|
    "#{method.rjust(7, ' ')} #{route}"
  end
end.flatten.sort.each do |route|
  puts route
end

run Site
