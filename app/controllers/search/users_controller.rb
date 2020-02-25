class Search::UsersController < ApplicationController
  def index
    # @users = User.where("name LIKE ? || email LIKE ?", "%#{params[:input]}%", "%#{params[:input]}%"  )

    #vue用
    @sended_thanks = current_user.sended_thanks
    @sended_users = []
    @sended_users << current_user.id
    @sended_thanks.each do |thank|
      @sended_users << thank.receiver_id
    end
    @users_vue = User.where("name LIKE ?" , "%#{params["0"]}%").where.not(id: @sended_users)
  end
end
