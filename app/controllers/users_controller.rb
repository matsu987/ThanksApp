class UsersController < ApplicationController
  before_action :redirect_root, only: [:edit]

  # def index
  #   @thanks = Thank.all
  #   @sended_thanks = current_user.sended_thanks
  #   @send_thanks = []
  #   @receivers = []
  #   @sended_thanks.each do |send_thank|
  #     @send_thanks << send_thank
  #     receiver_name = send_thank.receiver.family_name + send_thank.receiver.given_name
  #     @receivers   << receiver_name
  #   end
    
  #   respond_to do |format|
  #     format.html
  #     format.json
  #   end
  # end

  # def show
  #   @user = User.find(params[:id])
  # end

  def edit # アカウント設定ページ
  end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update(user_params)
  #     redirect_to user_path(@user)
  #   else
  #     render :edit
  #   end
  # end

  private
  def user_params
    if params[:avatar] != ""
      params.permit(:avatar, :family_name, :given_name)
    else
      params.permit(:family_name, :given_name)
    end
  end

  def redirect_root
    user = User.find_by(id: params[:id])
    return redirect_to root_path if user.blank? || current_user.id != user.id
  end
end
