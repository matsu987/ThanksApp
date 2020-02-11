class ThanksController < ApplicationController

  def index
    @thanks = Thank.all
    @sended_thanks = current_user.sended_thanks
    @send_thanks = []
    @receivers = []
    @sended_thanks.each do |send_thank|
      @send_thanks << send_thank
      @receivers   << send_thank.receiver.name
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @thank = Thank.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
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
    thank = Thank.find(params[:id])
    if thank.update(thank_params)
      render json: thank, status: :created
    else
      render json: { errors: thank.errors.full_messages }
    end
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
