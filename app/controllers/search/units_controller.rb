class Search::UnitsController < ApplicationController
  def index
    @units = Group.search_units
  end
end
