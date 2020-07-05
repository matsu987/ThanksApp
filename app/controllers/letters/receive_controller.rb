class Letters::ReceiveController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    # 受信一覧を取得したいというリクエストが来た時だけ発火
    if params["receive_year"]
      # 検索したい日付を定義
      search_date = params["receive_year"] + "-" + params["receive_month"] +  "-" + "01"
      # 受信したありレターを作成日ベースで検索
      received_thanks = @user.received_thanks.where(created_at: search_date.in_time_zone.all_month)
      # 受信したデータをVueに渡すために加工
      @received_thanks = []
      received_thanks.each do |received_thank|
        @received_thanks.push(
          {
            id: received_thank.id,
            text: received_thank.text,
            sender: {
              id: received_thank.sender.id,
              family_name: received_thank.sender.family_name,
              given_name: received_thank.sender.given_name,
              avatar: received_thank.sender.avatar
            },
            transmission_status: received_thank.transmission,
            reception_status: received_thank.reception_status
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
# 仮の日付
# search_date = '2016-1-25'

# 年での指定
# Item.where(created_at: search_date.in_time_zone.all_year)

# 月での指定
# Item.where(created_at: search_date.in_time_zone.all_month)

# 日での指定
# Item.where(created_at: search_date.in_time_zone.all_day)
# User.where(created_at: search_date.all_month)
# -- 年での指定
# SELECT "items".* 
# FROM "items"  
# WHERE ("items"."created_at" BETWEEN '2016-01-01 00:00:00' AND '2016-12-31 23:59:59')

# -- 月での指定
# SELECT "items".* 
# FROM "items"  
# WHERE ("items"."created_at" BETWEEN '2016-01-01 00:00:00' AND '2016-01-31 23:59:59')

# -- 日での指定
# SELECT "items".* 
# FROM "items"  
# WHERE ("items"."created_at" BETWEEN '2016-01-25 00:00:00' AND '2016-01-25 23:59:59')
