class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.unread.order(created_at: :desc)
  end
end
