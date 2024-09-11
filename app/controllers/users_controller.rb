class UsersController < ApplicationController
  def edit
  end

  def update
    if Current.user.update(user_params)
      redirect_to edit_user_path, notice: t("controllers.users.update.success")
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

  def user_params
    if password_params_blank?
      {email: permitted_params[:email]}
    else
      permitted_params
    end
  end

  def password_params_blank?
    permitted_params.values_at(
      :password,
      :password_confirmation,
      :password_challenge
    ).all?(&:blank?)
  end
end
