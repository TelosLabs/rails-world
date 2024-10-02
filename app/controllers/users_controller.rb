class UsersController < ApplicationController
  def edit
  end

  def update
    if Current.user.update(update_params)
      redirect_to edit_user_path, notice: t("controllers.users.update.success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def update_params
    if attempting_to_change_password?
      permitted_params
    else
      email_params
    end
  end

  def permitted_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :password_challenge
    ).with_defaults(password_challenge: "")
  end

  def email_params
    permitted_params
      .slice(:email, :password_challenge)
      .with_defaults(password_challenge: "")
  end

  def attempting_to_change_password?
    permitted_params
      .values_at(:password, :password_confirmation)
      .any?(&:present?)
  end
end
