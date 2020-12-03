class Api::Admin::RequestsController < ApplicationController
  before_action :check_request, only: :update
  def update
    if @error
      return @error
    else
      group = Group.find(params[:group_id])
      group_user = group.group_users.where(user_id: params[:user_id]).first
      group_user.update(request: true)
      group_user
    end
    render json: "ok", status: 200
  end

  def destroy
    @group =User.find(params[:user_id]).group_users.last
    @group.destroy
  end

  private

  def check_request
    @error = {text: "承認済み" , user_id: params[:user_id]} if params[:request] == true
  end
  def update_params
    params.permit(:user_id, :status, :company_id, :request)
  end
end
