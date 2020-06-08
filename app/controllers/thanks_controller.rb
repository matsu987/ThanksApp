class ThanksController < ApplicationController
  before_action :user_group_confirmation, except: [:index]

  def index
    @sended_thanks = current_user.sended_thanks
    @send_thanks = []
    @receivers = []
    @sended_thanks.each do |send_thank|
      @send_thanks << send_thank
      receiver = send_thank.receiver
      data = {name: send_thank.receiver.name, avatar: send_thank.receiver.avatar.url }
      @receivers << data
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @thank = Thank.find(params[:id])
    @login_avatar = ""
    @receiver_avatar = ""

    @login_user = {user: current_user, avatar: current_user.avatar.url}
    @receiver_user = {user: @thank.receiver, avatar: @thank.receiver.avatar.url}

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
    if thank.delete
      render json: thank, status: :created
    else
      render json: { errors: thank.errors.full_messages }
    end
  end

  private

  def thank_params
    params.require(:thank).permit(:text, :receiver_id).merge(sender_id: current_user.id)
  end

  def user_group_confirmation
    if current_user.groups.empty?
      redirect_to regist_groups_path
    end
  end

end
