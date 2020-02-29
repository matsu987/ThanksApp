# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(email: params[:email])
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: {success_introduction: "パスワード再設定のためのメールを送信いたしました。" }
    else
      render json: {errors_introduction: "登録されていないメールアドレスです。" }
    end
  end
  
  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])
    super if resource.nil? || resource.confirmed?
  end

  def confirm
    confirmation_token = params[:confirmation_token]
    self.resource = resource_class.find_by_confirmation_token!(confirmation_token)
    if resource.update(confirmation_params)
      self.resource = resource_class.confirm_by_token(confirmation_token)
      render json: {success_introduction: "パスワード設定いたしました。" }
    else
      render json: {errors_introduction: "パスワードを入力し直してください。" }
    end
  end
  
  private
  
  def confirmation_params
    params.permit(:password)
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
