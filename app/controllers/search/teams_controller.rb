class Search::TeamsController < ApplicationController
  def index
    @teams = Group.search_teams
  end
end
