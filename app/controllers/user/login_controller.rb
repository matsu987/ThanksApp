class User::LoginController < ApplicationController

  def update
    @user = User.find(params[:id])
    if @user.update(login_params)
      sign_out
      sign_in(@user)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def login_params
    params.permit(:email, :password)
  end
end
