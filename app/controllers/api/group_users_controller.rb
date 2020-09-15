class Api::GroupUsersController < ApplicationController

  def create # グループ参加申請
    if params[:group_id].present?
      group = Group.find(params[:group_id])
      group_user = group.group_users.new(group_id: params[:group_id], user_id: current_user.id)
      if group_user.save
        render json: group_user, status: 200
      else
        render json: { errors: group_user.errors.full_messages }
      end
    end
  end
end