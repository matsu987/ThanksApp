class Search::RanksController < ApplicationController
  def index
    rank_keys = User.ranks.keys
    rank_values = User.ranks.values
    ranks = rank_keys.zip(rank_values)
    @ranks = []
    ranks.each do |rank|
      @ranks.push( {id: rank[1], name: rank[0]} )
    end
  end
end
