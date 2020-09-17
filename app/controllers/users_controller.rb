class UsersController < ApplicationController
  before_action :redirect_root, only: [:edit]

  def edit # アカウント設定ページ
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

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
