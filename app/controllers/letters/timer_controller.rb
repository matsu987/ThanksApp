class Letters::TimerController < ApplicationController
  def index
    group = current_user.groups&.first&.root
    company = group.company
    thanks = Thank.where(group_id: group.id)
    thanks.where(transmission_status: true)&.each do |thank|
      thank.update(release: true)
    end
    thanks.where(transmission_status: false)&.destroy_all
    redirect_to root_path
  end
end