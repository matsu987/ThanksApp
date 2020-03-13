class ReceptionsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @received_thanks = user.received_thanks
    @receive_thanks = []
    @senders = []
    @received_thanks.each do |receive_thank|
      @receive_thanks << receive_thank
      @senders   << receive_thank.sender.name
    end
    respond_to do |format|
      format.html
      format.json
    end
  end
end
