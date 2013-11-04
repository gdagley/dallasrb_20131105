<!SLIDE commandline incremental>
# Adding Specs #

    $ ls -l
    -rw-r--r--  1 geoffrey  staff   303 Oct 22 13:55 Gemfile
    -rw-r--r--  1 geoffrey  staff   156 Oct 22 13:40 config.ru
    -rw-r--r--  1 geoffrey  staff   387 Oct 31 22:39 poker.rb
    -rw-r--r--  1 geoffrey  staff   924 Oct 22 16:57 poker_spec.rb
    -rw-r--r--  1 geoffrey  staff   653 Oct 31 22:53 spec_helper.rb

    $ more Gemfile
    source 'https://rubygems.org'
    ruby '2.0.0'

    gem 'grape'

    group :test do
      gem 'rspec'
      gem 'rack-test'
      gem 'json_spec'
    end

<!SLIDE smaller>
# The Helper #

    @@@ ruby
    # spec_helper.rb
    ENV["RACK_ENV"] ||= 'test'
    require 'rubygems'
    require 'bundler/setup'
    Bundler.require :default, ENV['RACK_ENV']
    require './poker'

    RSpec.configure do |config|
      config.include Rack::Test::Methods
      config.include JsonSpec::Helpers

      config.mock_with :rspec
      config.expect_with :rspec

      config.before(:each) do
        JsonSpec.reset
      end
    end

<!SLIDE smaller>
# The Specs #

    @@@ ruby
    require './spec_helper'

    describe Poker::API do
      def app
        @app ||= Poker::API.new
      end

      before do
        Leaderboard.reset
      end

      describe 'GET /leaderboard' do
        it 'should return an array of udid and scores' do
          Leaderboard.rank('6789', 1)
          Leaderboard.rank('9876', 2)

          get '/leaderboard'
          leaders = parse_json(last_response.body, 'leaders')
          leaders.first.should == ['9876', 2]
        end
      end
    end

<!SLIDE commandline incremental>
# Running The Specs #
    $ bundle exec rspec poker_spec.rb
    .

    Finished in 0.03882 seconds
    1 example, 0 failures

