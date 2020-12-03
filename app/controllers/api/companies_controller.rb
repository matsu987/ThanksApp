class Api::CompaniesController < ApplicationController

  def index # 複数のコミュニティを取得
    companies = Company.all
    render json: companies, status: 200
  end

  def create #コミュニティ登録
    company = Company.new(company_params)
    if company.save
      group = company.groups.new(name: params[:company][:name], user_ids: [current_user.id])
      group.group_users.first.status = "管理者"
      group.group_users.first.request = true
      if group.save
        render json: group, status: :created
      else
        render json: { errors: group.errors.full_messages }
      end
    else
      render json: { errors: company.errors.full_messages }
    end
  end

  def update # コミュニティ更新
    company = Company.find(params[:id])
    if company.update(company_params)
      group = Group.where(ancestry: nil, company_id: company.id).first
      if group.update(name: params[:company][:name])
        render json: group, status: :created
      else
        render json: { errors: group.errors.full_messages }
      end
    else
      render json: { errors: company.errors.full_messages }
    end
  end

  def belong_to_company # 所属しているコミュニティを取得
    group_users = current_user&.group_users
    admin_group_users = group_users&.where(status: 1)
    group_ids = []
    group_users.each do |group_user|
      group_ids << group_user.group_id
    end
    groups = Group.where(id: group_ids)


    case [group_users.present?, admin_group_users.present?]
    when [true, true]
      group = Group.find(admin_group_users.first.group_id)
      company_admin = Company.find(group.company_id)
      group_all = Group.where(company_id: company_admin.id).where.not(ancestry: nil)
      render json: {company: company_admin, admin: true, groups: groups, group_all: group_all }, status: 200
    when [true, false]
      group = Group.find(group_users.first.group_id)
      company = Company.find(group.company_id)
      group_all = Group.where(company_id: company.id).where.not(ancestry: nil)
      render json: {company: company, admin: false, groups: groups, group_all: group_all}, status: 200
    else
      render json: { errors: "error" }
    end
  end

  private
  def company_params
    params[:company][:release_time] = params[:company][:detailed_time] if params[:company][:detailed_time].present? # 公開日時に詳細日が設定されている場合公開日時を書き換え
    params.require(:company).permit(:name, :post_number, :address, :phone_number, :release_time)
  end
end