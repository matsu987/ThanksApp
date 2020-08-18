class Letters::SendController < ApplicationController
 def index
    # @user = User.find(params[:user_id])
    # 送信一覧を取得したいというリクエストが来た時だけ発火
    if params["send_year"]
      # 検索したい日付を定義
      search_date = params["send_year"] + "-" + params["send_month"] +  "-" + "01"
      # 送信したありレターを作成日ベースで検索
      send_thanks = current_user.sended_thanks.where(created_at: search_date.in_time_zone.all_month)
      # 送信したデータをVueに渡すために加工
      @send_thanks = []
      send_thanks.each do |send_thank|
        @send_thanks.push(
          {
            id: send_thank.id,
            text: send_thank.text,
            transmission_status: send_thank.transmisson_status,
            reception_status: send_thank.reception_status,
            receiver: {
              id: send_thank.receiver.id,
              name: send_thank.receiver.family_name + send_thank.receiver.given_name,
              avatar: send_thank.receiver.avatar
            },
            sender: {
              id: send_thank.sender.id,
              name: send_thank.sender.family_name + send_thank.sender.given_name,
              avatar: send_thank.sender.avatar
            }
          }
        )
      end
      respond_to do |format|
        format.html
        format.json
      end
    end
  end
end
