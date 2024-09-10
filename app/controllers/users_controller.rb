class UsersController < ApplicationController
  def edit
  end

  def update
    if Current.user.update(permitted_params)
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
end
