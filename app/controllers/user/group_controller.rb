class User::GroupController < ApplicationController
  def index # マイページにあるグループ情報の会社選択
    @groups = Group.where(ancestry: nil)
  end

  def create # ユーザーのグループ参加申請
    case [params[:company_id].present?, params[:parent_group_id].present?, params[:child_group_id].present?, params[:grandchild_group_id].present?]
    when [true, true, true, true]
      group = Group.find(params[:grandchild_group_id])
      groupuser = GroupUser.where(group_id: group.id, user_id: current_user.id).first_or_initialize
      groupuser.save
    when [true, true, true, false]
      group = Group.find(params[:child_group_id])
      groupuser = GroupUser.where(group_id: group.id, user_id: current_user.id).first_or_initialize
      groupuser.save
    when [true, true, false, false]
      group = Group.find(params[:parent_group_id])
      groupuser = GroupUser.where(group_id: group.id, user_id: current_user.id).first_or_initialize
      groupuser.save
    when [true, false, false, false]
      group = Group.find(params[:company_id])
      groupuser = GroupUser.where(group_id: group.id, user_id: current_user.id).first_or_initialize
      groupuser.save
    else
    end
  end

  def update
  end

  def destroy
    case [params[:company_id].present?, params[:parent_group_id].present?, params[:child_group_id].present?, params[:grandchild_group_id].present?]
    when [true, true, true, true] # 孫への所属削除
      group = current_user.group_users.where(group_id: params[:grandchild_group_id]).first
      group.destroy
    when [true, true, true, false] # 子への所属削除
      group = current_user.group_users.where(group_id: params[:child_group_id]).first
      group.destroy
    when [true, true, false, false] # 親への所属削除
      group = current_user.group_users.where(group_id: params[:parent_group_id]).first
      group.destroy
    when [true, false, false, false] # ルートへの所属削除
      group = current_user.group_users.where(group_id: params[:company_id]).first
      group.destroy
    end
  end

  def search # マイページにあるグループ情報のグループ検索
    @group_children = Group.find(params[:group_id])&.children
  end

  def belongs_group
    @groups = []
    current_user.groups.each do |group|
      case group.depth
      when 0 # ルート
        group.data_custom(@groups, group, nil, nil, nil)
      when 1 # 親
        group.data_custom(@groups, group.root, group, nil, nil)
      when 2 # 子
        group.data_custom(@groups, group.root, group.parent, group, nil)
      when 3 # 孫
        group.data_custom(@groups, group.root, group.parent.parent, group.parent, group)
      end
    end
  end
end
