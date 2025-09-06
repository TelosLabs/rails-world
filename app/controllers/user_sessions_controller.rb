class UserSessionsController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  rate_limit to: 3, 
    within: 1.minute, with: -> { 
      flash.now[:alert] = t("controllers.user_sessions.create.rate_limit")
      @user = User.new
      render :new, status: :too_many_requests
    }, 
    only: [:create],  by: -> { request.remote_ip }

  before_action :redirect_if_signed_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    after_sign_in_path = session[:after_sign_in_path].presence || root_path
    session[:after_sign_in_path] = nil

    @user = User.authenticate_by(email: session_params[:email], password: session_params[:password])

    if @user
      login @user
      redirect_to after_sign_in_path
    else
      redirect_to new_user_session_path, alert: t("controllers.user_sessions.create.alert")
    end
  end

  def destroy
    logout
    redirect_to new_user_session_path
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def redirect_if_signed_in
    redirect_to root_path if user_signed_in?
  end
end
