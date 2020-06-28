class GroupsController < ApplicationController
  before_action :group_params, only: [:create]

  def index
    group_users = current_user.group_users
    group_users_admin = group_users.where(status: 1)

    case [group_users.present?, group_users_admin.present?]
    when [true, true]
      @group_admin = Group.find(group_users_admin.first.group_id)
    when [true, false]
      @group = Group.find(group_users.first.group_id).root
    else
    end
  end

  def new
  end

  def create #部署登録
    case [@group_params_1[:name].present?, @group_params_2[:name].present?, @group_params_3[:name].present?]
    when [true, false, false]
      @group_1 = @parent_group.children.create(@group_params_1)
    when [true, true, false]
      @group_1 = @parent_group.children.create(@group_params_1)
      @group_2 = @group_1.children.create(@group_params_2)
    when [true, true, true]
      @group_1 = @parent_group.children.create(@group_params_1)
      @group_2 = @group_1.children.create(@group_params_2)
      @group_3 = @group_2.children.create(@group_params_3)
    else
      redirect_to new_group_path and return
    end
    redirect_to new_group_path
  end

  def get_group #グループ参加画面のjs用
    @group = Group.find(params[:group_id])
    @group_children = @group.children
  end

  private
  def group_params
    @parent_group = Group.find(params[:company][:id])
    @group_params_1 = {name: params[:parent_group][:name], company_id: @parent_group.company_id}
    @group_params_2 = {name: params[:child_group][:name], company_id: @parent_group.company_id}
    @group_params_3 = {name: params[:grandchild_group][:name], company_id: @parent_group.company_id}
  end
end
