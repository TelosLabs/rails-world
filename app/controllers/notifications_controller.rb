class NotificationsController < ApplicationController
  def index
    threshold = 10.minutes.ago
    notifications = current_user.notifications.unread.order(created_at: :desc)
    @recent_notifications = notifications.where(created_at: threshold..)
    @past_notifications = notifications.where(created_at: ...threshold)
  end
end
