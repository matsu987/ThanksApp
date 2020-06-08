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
    @group_1 = @parent_group.children.new(@group_params_1)
    if @group_1.save
      if @group_params_2[:name] != ""
        @group_2 = @group_1.children.new(@group_params_2)
        if @group_2.save
          if @group_params_3[:name] != ""
            @group_3 = @group_2.children.new(@group_params_3)
            if @group_3.save
            end
          end
        end
      end
      redirect_to regist_groups_path
    else
      render :new
    end
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

  # def admin #グループ設定（管理者）
  #   group_users = current_user.group_users.where(status: 1)
  #   @groups = []
  #   group_users.each do |group_user|
  #     group = Group.find(group_user.group_id)
  #     group.subtree.each do |group|
  #      @groups << group
  #     end
  #   end
  # end

  def depart_request_create #グループ申請許可
  end

  private
  def group_params
    @parent_group = Group.find(params[:group][:id])
    @group_params_1 = {name: params[:group][:name_1], company_id: @parent_group.company_id}
    @group_params_2 = {name: params[:group][:name_2], company_id: @parent_group.company_id}
    @group_params_3 = {name: params[:group][:name_3], company_id: @parent_group.company_id}
  end

  def depart_join_params
  end
end
