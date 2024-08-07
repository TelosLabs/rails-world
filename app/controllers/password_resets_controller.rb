class PasswordResetsController < ApplicationController
  allow_unauthenticated_access

  before_action :set_user_by_token, only: [:edit, :update]

  def new
  end

  def edit
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      PasswordMailer.with(
        user: @user,
        token: @user.generate_token_for(:password_reset)
      ).password_reset.deliver_later
    end

    redirect_to post_submit_password_reset_path
  end

  def update
    if @user.update(password_params)
      redirect_to new_user_session_path, notice: t("controllers.password_resets.update.notice")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user_by_token
    @user = User.find_by_token_for(:password_reset, params[:token])
    return if @user.present?

    redirect_to new_password_reset_path, alert: t("controllers.password_resets.errors.invalid_token")
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
