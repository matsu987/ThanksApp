class CompaniesController < ApplicationController

  def index
    group_users = current_user.group_users
    group_users_admin = group_users.where(status: 1)

    case [group_users.present?, group_users_admin.present?]
    when [true, true]
      group = Group.find(group_users_admin.first.group_id)
      @company_admin = Company.find(group.company_id)
    when [true, false]
      group = Group.find(group_users.first.group_id)
      @company = Company.find(group.company_id)
    else
    end
  end

  def create #会社登録
    @company = Company.new(company_params)
    if @company.save
      group = @company.groups.new(name: params[:company][:name], user_ids: [current_user.id])
      group.group_users.first.status = "管理者"
      group.group_users.first.request = true
      if group.save
        redirect_to new_group_path
      else
        redirect_to new_group_path
      end
    else
      redirect_to new_group_path
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      group = Group.where(ancestry: nil, company_id: @company.id).first
      group.update(name: params[:company][:name])
      redirect_to new_group_path
    else
      redirect_to new_group_path
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :post_number, :address, :phone_number)
  end
end
