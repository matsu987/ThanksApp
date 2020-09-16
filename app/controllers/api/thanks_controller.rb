class Api::ThanksController < ApplicationController

  def create
    thank = Thank.new(thank_params)
    thank.transmission_status = true if params[:thank][:transmission_status] == true
    if thank.save
      render json: thank, status: 200
    else
      render json: { errors: thank.errors.full_messages }
    end
  end

  private

  def thank_params
    params.require(:thank).permit(:text).merge(sender_id: current_user.id, receiver_id: params[:receiver][:id],group_id: current_user.groups.first.root_id)
  end
end
