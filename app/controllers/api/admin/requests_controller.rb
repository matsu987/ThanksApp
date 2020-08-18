class Api::Admin::RequestsController < ApplicationController
  before_action :check_request, only: :update
  def update
    if @error
      return @error
    else
      @user = User.find(params[:user_id])
      @user.group_users.first.update(request: true)
      return @user
    end
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
