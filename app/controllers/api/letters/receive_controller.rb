class Api::Letters::ReceiveController < ApplicationController
  def index
    # @user = User.find(params[:user_id])
    # 受信一覧を取得したいというリクエストが来た時だけ発火
    if params["receive_year"]
      # 検索したい日付を定義
      search_date = params["receive_year"] + "-" + params["receive_month"] +  "-" + "01"
      # 受信したありレターを作成日ベースで検索
      received_thanks = current_user.received_thanks.where(created_at: search_date.in_time_zone.all_month).where(release: true)
      # 受信したデータをVueに渡すために加工
      @received_thanks = []
      received_thanks.each do |received_thank|
        @received_thanks.push(
          {
            id: received_thank.id,
            text: received_thank.text,
            transmission_status: received_thank.transmission_status,
            reception_status: received_thank.reception_status,
            receiver: {
              id: received_thank.receiver.id,
              name: received_thank.receiver.family_name + received_thank.receiver.given_name,
              avatar: received_thank.receiver.avatar
            },
            sender: {
              id: received_thank.sender.id,
              name: received_thank.sender.family_name + received_thank.sender.given_name,
              avatar: received_thank.sender.avatar
            }
          }
        )
      end
      render json: @received_thanks, status: 200
    end
  end
end
