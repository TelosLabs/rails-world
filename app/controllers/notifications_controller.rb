class NotificationsController < ApplicationController
  include Pagy::Backend

  def index
    notifications = current_user.notifications.unread.newest_first
    @pagy, @notifications = pagy notifications, items: 5
  end
end
