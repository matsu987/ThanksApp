class UsersController < ApplicationController

  def index
    @thanks = Thank.all
    @sended_thanks = current_user.sended_thanks
    @send_thanks = []
    @receivers = []
    @sended_thanks.each do |send_thank|
      @send_thanks << send_thank
      @receivers   << send_thank.receiver.name
    end

    # if current_user.avatar.attached?
    #   avatar = current_user.avatar #eyecatchは添付した画像ファイル

    #   if avatar.present?
    #     @avatar = encode_base64(avatar) # 画像ファイルを1.で定義したメソッドでBase64エンコードし、renderするデータに追加する
    #   end
    # end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def encode_base64(image_file)
    image = Base64.encode64(image_file.download) # 画像ファイルをActive Storageでダウンロードし、エンコードする
    blob = ActiveStorage::Blob.find(image_file[:id]) # Blobを作成
    "data:#{blob[:content_type]};base64,#{image}" # Vue側でそのまま画像として読み込み出来るBase64文字列にして返す
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :show
    end
  end

  def image_destroy
    user = User.find(params[:id])
    user.update(avatar: "")
    redirect_to user_path(user)
  end

  private
  def user_params
    params.require(:user).permit(:avatar)
  end
end
