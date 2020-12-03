class Api::Admin::UsersController < ApplicationController
  before_action :check_status, only: :update

  def index
    @users = []
    @company_group = current_user.groups.first.root
    @company_group.subtree.each do |group|
      group.users.each do |user|
        request = group.group_users.where(user_id: user.id).first.request
        user_info = {user: user, group: group, request: request}
        @users.push(user_info)
      end
    end
    render json: @users, status: 200
  end

  def update
    if @error
      return @error
    else
      @group_user = GroupUser.find_by(user_id: update_params[:user_id])
      case update_params[:status]
        when "管理者" 
          then
          @group_user.update(status: "管理者")
        else 
          @group_user.update(status: "一般")
      end
      @user = @group_user.user
    end
  end

  def destroy
    @user =User.find(params[:user_id])
    @user.destroy
  end
  private

  def check_status
    # 管理者が常に1人以上かどうかチェックする。
    # 階層が一番上のGroupをチェック
    mg_cont = 0
    company_id = User.find(params[:user_id]).groups.first.company_id
    Company.find(company_id).groups.each do |group|
      group.group_users.each do |user|
        mg_cont += 1 if user.status == "管理者" && user.id != params[:user_id]
      end
    end
    @error = {text: "管理者が1人しかいない" , user_id: params[:user_id]} unless mg_cont > 0
  end

  def update_params
    params.permit(:user_id, :status, :company_id, :request)
  end
end
