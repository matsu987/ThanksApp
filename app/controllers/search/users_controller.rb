class Search::UsersController < ApplicationController
  def index
    @users = User.where("name LIKE ? || email LIKE ?", "%#{params[:input]}%", "%#{params[:input]}%"  )
  end
end
