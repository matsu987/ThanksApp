class Api::Admin::UsersController < ApplicationController
  def index
    current_user.groups.each do |group|
      @company_group = group if group.ancestry == nil
    end
    # 会社に所属しているユーザー一覧
    @users = @company_group.users
  end
end
