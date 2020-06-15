class Search::GroupsController < ApplicationController
  def index
    group_ids = []
    current_user.groups.each do |group|
      if group.root?
        group_ids << group.id
      else
        group_ids << group.root_id
      end
    end
    @groups = Group.where(id: group_ids)
  end
end
