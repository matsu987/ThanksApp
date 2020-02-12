class Search::GroupsController < ApplicationController
  def index
    @groups = Group.search_groups
  end
end
