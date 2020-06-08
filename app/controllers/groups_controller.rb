class GroupsController < ApplicationController
  before_action :group_params, only: [:create]
  def new #部署登録画面
    if current_user.groups.empty?
      render :regist
    end
    @group = Group.new
    @companies = current_user.groups
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
    redirect_to regist_groups_path
  end

  def regist #グループ設定画面
  end

  def depart_join #部署参加画面
  end

  def depart_join_create #部署参加申請
    group = Group.find(params[:group_id])
    if group.update(user_ids: current_user.id)
      redirect_to root_path
    else
      render :depart_join
    end
  end

  def get_group #グループ参加画面のjs用
    @group = Group.find(params[:group_id])
    @group_children = @group.children
  end

  def depart_request_create #グループ申請許可
  end

  private
  def group_params
    if params[:group][:id].empty?
      redirect_to new_group_path
    else
      @parent_group = Group.find(params[:group][:id])
      @group_params_1 = {name: params[:group][:name_1], company_id: @parent_group.company_id}
      @group_params_2 = {name: params[:group][:name_2], company_id: @parent_group.company_id}
      @group_params_3 = {name: params[:group][:name_3], company_id: @parent_group.company_id}
    end
  end
end
