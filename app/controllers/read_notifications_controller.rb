class ReadNotificationsController < ApplicationController
  def create
    current_user.notifications.mark_as_read
    redirect_to notifications_path
  end
end
