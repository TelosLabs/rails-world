class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    @user = User.authenticate_by(email: session_params[:email], password: session_params[:password])

    if @user
      login @user
      redirect_to root_path, notice: t("controllers.sessions.create.notice")
    else
      flash[:alert] = t("controllers.sessions.create.alert")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t("controllers.sessions.destroy.notice")
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
