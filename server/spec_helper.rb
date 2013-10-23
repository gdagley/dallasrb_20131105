ENV["RACK_ENV"] ||= 'test'

require 'rubygems'
require 'bundler/setup'

Bundler.require :default, ENV['RACK_ENV']

require './poker'

# Configure Fdoc
require 'fdoc/spec_watcher'
Fdoc.service_path = File.expand_path(File.dirname(__FILE__) + "/fdoc")
Fdoc.decide_success_with do |response, status|
  status.to_i < 400
end

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.include Rack::Test::Methods
  config.include Fdoc::SpecWatcher
  config.include JsonSpec::Helpers


  config.mock_with :rspec
  config.expect_with :rspec

  config.before(:each) do
    JsonSpec.reset
  end
end
