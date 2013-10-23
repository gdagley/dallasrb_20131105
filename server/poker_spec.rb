require './spec_helper'

describe Poker::API do
  def app
    @app ||= Poker::API.new
  end

  before do
    Leaderboard.reset
  end

  describe 'POST /poke', :fdoc => 'poke' do

    it 'should require a udid' do
      post '/poke'
      last_response.status.should == 500
    end

    it 'should return the number of pokes' do
      post '/poke', :udid => '1234'
      parse_json(last_response.body, 'pokes').should == 1
    end

    it 'should increment the number of pokes' do
      post '/poke', :udid => '1234'
      post '/poke', :udid => '1234'
      parse_json(last_response.body, 'pokes').should == 2
    end
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
