class NotificationSettingsController < ApplicationController
  def show
  end

  def update
    current_user.profile.update!(permitted_params)
    redirect_to notification_settings_path
  end

  private

  def permitted_params
    params.require(:profile).permit(:web_push_notifications, :mail_notifications)
  end
end
