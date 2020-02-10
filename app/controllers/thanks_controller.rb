class ThanksController < ApplicationController

  def index
    @thanks = Thank.all
  end

  def edit
    @thank = Thank.find(params[:id])
  end

  def create
    thank = Thank.new(thank_params)
    if thank.save
      render json: thank, status: :created
    else
      render json: { errors: thank.errors.full_messages }
    end
  end

  def update
    @thank = Thank.find(params[:id]).update(thank_params)
    redirect_to root_path
  end

  def destroy
    thank = Thank.find(params[:id])
    thank.delete
    redirect_to root_path
  end

  private

  def thank_params
    params.require(:thank).permit(:text, :receiver_id).merge(sender_id: current_user.id)
  end
end
