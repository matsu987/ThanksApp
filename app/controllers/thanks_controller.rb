class ThanksController < ApplicationController

  def index
    @sended_thanks = current_user.sended_thanks
    @send_thanks = []
    @receivers = []
    @sended_thanks.each do |send_thank|
      @send_thanks << send_thank
      receiver = send_thank.receiver
      # avatar_image = {}
      # if receiver.avatar.attached?
      #   avatar = receiver.avatar
      #   if avatar.present?
      #     avatar_image = {image: encode_base64(avatar)} # 画像ファイルを1.で定義したメソッドでBase64エンコードし、renderするデータに追加する
      #   end
      # end
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
    # if current_user.avatar.attached?
    #   avatar = current_user.avatar
    #   if avatar.present?
    #     @login_avatar = encode_base64(avatar) # 画像ファイルを1.で定義したメソッドでBase64エンコードし、renderするデータに追加する
    #   end
    # end
    @login_user = {user: current_user, avatar: current_user.avatar.url}

    # if @thank.receiver.avatar.attached?
    #   avatar = @thank.receiver.avatar
    #   if avatar.present?
    #     @receiver_avatar = encode_base64(avatar) # 画像ファイルを1.で定義したメソッドでBase64エンコードし、renderするデータに追加する
    #   end
    # end
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

  def encode_base64(image_file)
    image = Base64.encode64(image_file.download) # 画像ファイルをActive Storageでダウンロードし、エンコードする
    blob = ActiveStorage::Blob.find(image_file[:id]) # Blobを作成
    "data:#{blob[:content_type]};base64,#{image}" # Vue側でそのまま画像として読み込み出来るBase64文字列にして返す
  end

  private

  def thank_params
    params.require(:thank).permit(:text, :receiver_id).merge(sender_id: current_user.id)
  end
end
