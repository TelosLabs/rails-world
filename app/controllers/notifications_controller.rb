class NotificationsController < ApplicationController
  include Pagy::Backend

  def index
    notifications = current_user.notifications.unread.includes(event: {record: :speakers}).order(created_at: :desc)
    @pagy, @notifications = pagy notifications, items: 5
  end
end
