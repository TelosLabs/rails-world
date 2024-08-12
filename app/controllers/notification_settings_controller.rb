class NotificationSettingsController < ApplicationController
  def show
  end

  def update
    current_user.profile.update!(permitted_params)
    redirect_to notification_settings_path, notice: t("controllers.notification_settings.update.success")
  end

  private

  def permitted_params
    params.require(:profile).permit(:in_app_notifications, :mail_notifications)
  end
end
