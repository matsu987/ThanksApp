class ThanksTimer
  def load
    puts "load"
    today_time = Time.now
    Company.all.each do |company|
      thanks = company&.groups&.first&.thanks&.where(create_at: today_time.all_month, release: true) # 会社内グループで、当月に公開済みになっている全てメッセージ
      unless thanks.present?
        case company.release_time # 会社のメッセージ公開日時
        when "月末"
          release_thanks(thanks) if today_time.day == today_time.end_of_month.day #現在の日時が月末であるか？
        when "中旬"
          release_thanks(thanks) if today_time.day.to_i >= 15
        when "初旬"
          release_thanks(thanks)
        end

        if company.release_time.to_i != 0 # 会社のメッセージ公開日時が詳細設定（0~31日）がされている場合
          public_day = company.release_time
          if today_time.day.to_i >= public_day.to_i # 本日が公開日時を超えている場合
            release_thanks(thanks)
          end
        end
      end
    end
  end

  def release_thanks(thanks)
    puts "release"
    thanks.where(transmission_status: true)&.each do |thank|
      thank.update(release: true)
    end
    thanks.where(transmission_status: false)&.destroy_all
  end
end

