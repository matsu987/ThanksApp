class Letters::TimerController < ApplicationController
  def index
    group = current_user.groups&.first&.root
    company = group.company
    thanks = Thank.where(group_id: group.id)
    thanks.where(transmission_status: true)&.each do |thank|
      thank.update(release: true)
    end
    thanks.where(transmission_status: false)&.destroy_all

    year = Time.now.year.to_s
    month = Time.now.month.to_i
    last_day = Date.new(Time.now.year, (Time.now.month + 1), -1).day.to_s
    company.update(release_time: Time.new(year, (month + 1), last_day, 23, 50, 0, "+09:00" ))
    redirect_to new_group_path
  end
end