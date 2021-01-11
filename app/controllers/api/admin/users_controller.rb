class Api::Admin::UsersController < ApplicationController
  before_action :check_status, only: :update

  def index
    @users = []
    @company_group = current_user.groups.first.root
    @company_group.subtree.each do |group|
      group.users.each do |user|
        group_user = user.group_users.where(group_id: group.id).first
        user_info = {user: user, group: group, request: group_user.request, status: group_user.status}
        @users.push(user_info)
      end
    end
    render json: @users, status: 200
  end

  def update
    if @error
      return @error
    else
      @user = User.find(params[:user_id])
      case update_params[:status]
        when "管理者"
          @user.group_users.each { |group_user| group_user.update(status: "管理者")}
        else
          @user.group_users.each { |group_user| group_user.update(status: "一般")}
      end
      render json: @user, status: 200
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
