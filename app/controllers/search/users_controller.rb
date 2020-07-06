class Search::UsersController < ApplicationController
  def index
    case [params[:selectGroup].present?, params[:keyword].present?]
    when [true, true] # グループ検索、ユーザー検索
      group_ids = Group.find(params[:selectGroup]).subtree_ids
      group_users = GroupUser.where(group_id: group_ids)
      user_ids = []
      group_users.each do |group_user|
        user_ids << group_user.user_id
      end
      @users_vue = User.where(id: user_ids).where("family_name LIKE ? OR email LIKE ?", "#{params["keyword"]}%", "%#{params["keyword"]}%").where.not(id: current_user.id)
    when [true, false] # グループ検索のみ
      group_ids = Group.find(params[:selectGroup]).subtree_ids
      group_users = GroupUser.where(group_id: group_ids).where.not(user_id: current_user.id)
      group_user_ids = group_users.map{ |e| e.user_id }.uniq
      @users_vue = []
      group_user_ids.each do |group_user_id|
        user = User.find(group_user_id)
        @users_vue << user
      end
    when [false, true] # ユーザー検索のみ
      @users_vue = User.where("family_name LIKE ? OR email LIKE ?", "#{params["keyword"]}%", "%#{params["keyword"]}%").where.not(id: current_user.id)
    else
      @users_vue = []
    end
  end
end
