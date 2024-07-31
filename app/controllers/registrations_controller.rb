class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  before_action :redirect_if_signed_in

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)

    if @user.save
      login @user
      redirect_to edit_profile_path(@user.profile.uuid)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def redirect_if_signed_in
    redirect_to root_path if user_signed_in?
  end
end
