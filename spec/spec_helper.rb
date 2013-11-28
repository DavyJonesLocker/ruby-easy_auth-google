ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'
Dir[Rails.root.join('../config/**/*.rb')].each {|f| require f}
