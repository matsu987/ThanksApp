class CompaniesController < ApplicationController
  def new #会社情報登録画面
    @company = Company.new
  end

  def create #会社登録
    @company = Company.new(company_params)
    if @company.save
      group = @company.groups.new(name: params[:company][:name], user_ids: [current_user.id])
      group.group_users.first.status = "管理者"
      group.group_users.first.request = true
      if group.save
        redirect_to regist_groups_path
      else
        render :new
      end
    else
      render :new
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :post_number, :address, :phone_number)
  end
end
