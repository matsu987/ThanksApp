class Search::UsersController < ApplicationController
  def index
    #vue用
    @sended_thanks = current_user.sended_thanks
    @sended_users = []
    @sended_users << current_user.id
    @sended_thanks.each do |thank|
      @sended_users << thank.receiver_id
    end

    case [params[:selectGroup].present?, params[:keyword].present?]
    when [true, true] # グループ検索、ユーザー検索
      group_ids = Group.find(params[:selectGroup]).subtree_ids
      group_users = GroupUser.where(group_id: group_ids)
      user_ids = []
      group_users.each do |group_user|
        user_ids << group_user.user_id
      end
      @users_vue = User.where(id: user_ids).where("family_name LIKE ? OR email LIKE ?", "#{params["keyword"]}%", "%#{params["keyword"]}%").where.not(id: @sended_users)
    when [true, false] # グループ検索のみ
      group_ids = Group.find(params[:selectGroup]).subtree_ids
      group_users = GroupUser.where(group_id: group_ids).where.not(user_id: @sended_users)
      @users_vue = []
      group_users.each do |group_user|
        @users_vue << group_user.user
      end
    when [false, true] # ユーザー検索のみ
      @users_vue = User.where("family_name LIKE ? OR email LIKE ?", "#{params["keyword"]}%", "%#{params["keyword"]}%").where.not(id: @sended_users)
    else
      @user_vue = []
    end
  end
end
