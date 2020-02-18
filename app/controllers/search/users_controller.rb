class Search::UsersController < ApplicationController
  def index
    @users = User.where("name LIKE ? || email LIKE ?", "%#{params[:input]}%", "%#{params[:input]}%"  )

    #vue用
    @users_vue = User.where("name LIKE ? || email LIKE ?", "%#{params["0"]}%", "%#{params["0"]}%"  )
  end
end
