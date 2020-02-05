class ThanksController < ApplicationController

  def create
    thank = Thank.new(thank_params)
    if thank.save
      render json: thank, status: :created
    else
      render json: { errors: thank.errors.full_messages }
    end
  end

  private

  def thank_params
    params.require(:thank).permit(:text, :receiver_id).merge(sender_id: 2)
  end
end
