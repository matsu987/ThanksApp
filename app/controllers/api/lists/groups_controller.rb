class Api::Lists::GroupsController < ApplicationController
  def index
    @parent_groups        = Group.find(params[:company_id]).children

    
    case params[:parent_id]
      when "-"
        then
        @children_groups = []
      else
        @children_groups      = Group.find(params[:parent_id]).children
    end

    case  params[:children_id]
      when "-"
        then
        @grandchildren_groups = []
      else
        @grandchildren_groups = Group.find(params[:children_id]).children
    end
    
  end
end