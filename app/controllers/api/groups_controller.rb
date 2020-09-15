class Api::GroupsController < ApplicationController
  before_action :group_params, only: [:create]

  def index # 複数のグループを取得
  end

  def create # グループ登録
    group = @parent_group.children.new(@group_params) if @group_params[:name].present?
    if group&.save
      render json: group, status: 200
    else
      render json: { errors: group.errors.full_messages }
    end
  end

  def belong_to_groups # 所属しているグループを取得（複数）
  end

  private
  def group_params
    @parent_group = Group.find(params[:company][:id]) if params[:company].present?
    @parent_group = Group.find_by(company_id: params[:admin_company][:company][:id]) if params[:admin_company][:company].present?
    @group_params = {name: params[:parent_group][:name], company_id: @parent_group.company_id}
  end
end