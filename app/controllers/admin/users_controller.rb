class Admin::UsersController < ApplicationController
    before_action :if_not_admin
    before_action :set_user, only: [:edit, :update, :destroy]

    def index
        @user = User.includes(:groups)
    end

    def new
        @user = User.new
    end

    def create
        user = User.new(user_management_params)
        if user.save
        render :create
        else
        render :new
        end
    end

    def edit
    end

    def update
        if @user.update(user_management_params)
            redirect_to  admin_users_path
        else
            render :edit
        end
    end

    def destroy
        if @user.destroy
            redirect_to  admin_users_path
        else
            render :index
        end
    end

    private

    def user_management_params
        params.require(:user).permit(:name, :rank, :status, :email, :password)
    end

    def if_not_admin
        redirect_to root_path unless current_user.status === "管理者"
    end

    def set_user
        @user = User.find(params[:id])
    end
end
