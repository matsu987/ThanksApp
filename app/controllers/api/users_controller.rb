class Api::UsersController < ApplicationController

  def login # ログインしているユーザーを取得
    render json: current_user
  end
end