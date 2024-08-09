class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.unread
  end
end
