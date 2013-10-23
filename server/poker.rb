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
