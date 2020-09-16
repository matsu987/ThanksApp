class GroupsController < ApplicationController
  # before_action :group_params, only: [:create]
  before_action :redirect_root, only: [:index]


  def index
    # group_users = current_user.group_users
    # group_users_admin = group_users.where(status: 1)

    # case [group_users.present?, group_users_admin.present?]
    # when [true, true]
    #   @group_admin = Group.find(group_users_admin.first.group_id)
    # when [true, false]
    #   @group = Group.find(group_users.first.group_id).root
    # else
    # end
  end

  def new
  end


  private
  # def group_params
  #   @parent_group = Group.find(params[:company][:id])
  #   @group_params_1 = {name: params[:parent_group][:name], company_id: @parent_group.company_id}
  #   @group_params_2 = {name: params[:child_group][:name], company_id: @parent_group.company_id}
  #   @group_params_3 = {name: params[:grandchild_group][:name], company_id: @parent_group.company_id}
  # end

  def redirect_root
    user = User.find_by(id: params[:user_id])
    return redirect_to root_path if user.blank? || current_user.id != user.id
  end
end
