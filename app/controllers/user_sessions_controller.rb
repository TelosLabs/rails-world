class UserSessionsController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  before_action :redirect_if_signed_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.authenticate_by(email: session_params[:email], password: session_params[:password])

    if @user
      login @user
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def redirect_if_signed_in
    redirect_to root_path if user_signed_in?
  end
end
