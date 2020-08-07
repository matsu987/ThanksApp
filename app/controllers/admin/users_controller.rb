class Admin::UsersController < ApplicationController
    before_action :if_not_admin

    def index
    end

    private

    def if_not_admin
        count = 0
        current_user.group_users.each do |group_user| 
            count += 1 if group_user.status == "管理者"
        end
        redirect_to root_path unless count > 0
    end
end
