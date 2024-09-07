class UserSessionSettingsController < ApplicationController
  def edit
  end

  def update
    if current_user.update(permitted_params)
      redirect_to edit_user_session_setting_path, notice: "Your session has been updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :password_challenge
    ).with_defaults(password_challenge: "")
  end
end
