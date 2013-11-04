<!SLIDE commandline incremental>

# Putting It Together #

    $ ls -l
    -rw-r--r--  1 geoffrey  staff   303 Oct 22 13:55 Gemfile
    -rw-r--r--  1 geoffrey  staff   156 Oct 22 13:40 config.ru
    -rw-r--r--  1 geoffrey  staff   387 Oct 22 16:43 poker.rb

    $ more Gemfile
    source 'https://rubygems.org'
    ruby '2.0.0'

    gem 'grape'

    $ more config.ru
    ENV['RACK_ENV'] ||= 'development'

    require 'rubygems'
    require 'bundler/setup'

    Bundler.require :default, ENV['RACK_ENV']

    require './poker'

    run Poker::API

<!SLIDE smaller>
# The API #

    @@@ ruby
    # poker.rb
    require './leaderboard'

    module Poker
      class API < Grape::API
        format :json

        get :leaderboard do
          present :leaders => Leaderboard.leaders
        end

        post :poke do
          error!({:error => 'Not identified'}, 500) unless params[:udid]
          member = params[:udid]
          Leaderboard.increment(member)
          present({:pokes => Leaderboard.score_for(member)})
        end
      end
    end

.notes Look at Grape::API (similar to ActionController). Look at format :json.  Look at present. Look at error!()

<!SLIDE bullets smaller incremental>
# Making It Awesome #

* Testing with [RSpec](https://github.com/rspec/rspec)
* Verify JSON responses with [json_spec](https://github.com/collectiveidea/json_spec)
* API documentation **AND** validation with [fdoc](https://github.com/square/fdoc)

