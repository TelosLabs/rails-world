class NotificationsSettingsController < ApplicationController
  def show
  end

  def update
    current_user.profile.update!(notifications_settings_params)
    redirect_to notifications_settings_path
  end

  def notifications_settings_params
    params.require(:profile).permit(:in_app_notifications, :mail_notifications)
  end
end
