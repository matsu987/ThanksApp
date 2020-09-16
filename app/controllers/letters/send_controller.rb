class Letters::SendController < ApplicationController
  before_action :redirect_root

  def index
  end

  private
  def redirect_root
    user = User.find_by(id: params[:user_id])
    return redirect_to root_path if user.blank? || current_user.id != user.id
  end
end
