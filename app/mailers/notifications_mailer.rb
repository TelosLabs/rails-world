class NotificationsMailer < ApplicationMailer
  default from: "notifications@railsworld.com"
  def session_notification
    @user = params[:user]
    @message = params[:message]
    @session = params[:session]
    mail(to: @user.email, subject: "Notification")
  end
end
