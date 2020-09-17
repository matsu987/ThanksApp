class Api::UsersController < ApplicationController

  def login # ログインしているユーザーを取得
    render json: current_user
  end

  def signout # ログアウト
    session.delete(:user_id)
    render json: "200", status: 200
  end

  def destroy # 退会
    current_user.destroy
    render json: "200", status: 200
  end
end