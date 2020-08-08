class Api::Admin::UsersController < ApplicationController
  before_action :check_status, only: :update

  def index
    current_user.groups.each do |group|
      @company_group = group if group.ancestry == nil
    end
    # 会社に所属しているユーザー一覧
    @users = @company_group.users
  end

  def update
    if @error
      return @error
    else
      @group_user = GroupUser.find_by(user_id: update_params[:user_id], group_id: update_params[:company_id])
      case update_params[:status]
      when "管理者" then @group_user.update(status: "一般")
      else @group_user.update(status: "管理者")
      end
      @user = @group_user.user
    end
  end

  private

  def check_status
    @error = {text: "管理者が1人しかいない" , user_id: params[:user_id]} unless GroupUser.where(status: "管理者", group_id: update_params[:company_id]).length > 2
  end
  def update_params
    params.permit(:user_id, :status, :company_id)
  end
end
