class NotificationsController < ApplicationController
  def index
    notifications = current_user.notifications.unread.order(created_at: :desc)
    @pagy, @notifications = pagy notifications, items: 5
  end
end
