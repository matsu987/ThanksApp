class Search::UsersController < ApplicationController
  def index
    #vue用
    @sended_thanks = current_user.sended_thanks
    @sended_users = []
    @sended_users << current_user.id
    @sended_thanks.each do |thank|
      @sended_users << thank.receiver_id
    end
    if params[:selectGroup].present?
      group_ids = Group.find(params[:selectGroup]).subtree_ids
      group_users = GroupUser.where(group_id: group_ids)
      user_ids = []
      group_users.each do |group_user|
        user_ids << group_user.user_id
      end
      @users_vue = User.where(id: user_ids).where("name LIKE ? OR email LIKE ?", "#{params["0"]}%", "#{params["0"]}%").where.not(id: @sended_users)
    else
      @users_vue = User.where("name LIKE ? OR email LIKE ?", "#{params["0"]}%", "#{params["0"]}%").where.not(id: @sended_users)
    end
  end
end
