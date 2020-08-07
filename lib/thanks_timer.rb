class ThanksTimer
  def load
    puts "load"
    Company.all.each do |company|
      if company.release_time <= Time.now
        puts "release"
        group = Group.find_by(company_id: company.id)
        thanks = Thank.where(group_id: group.id)
        thanks.where(transmission_status: true)&.each do |thank|
          thank.update(release: true)
        end
        thanks.where(transmission_status: false)&.destroy_all
    
        year = Time.now.year.to_s
        month = Time.now.month.to_i
        last_day = Date.new(Time.now.year, (Time.now.month + 1), -1).day.to_s
        company.update(release_time: Time.new(year, (month + 1), last_day, 23, 50, 0, "+09:00" ))
      end
    end
  end
end

