class NotificationsController < ApplicationController
  include Pagy::Backend

  after_action :mark_as_read

  def index
    notifications = current_user.notifications.newest_first
    @pagy, @notifications = pagy notifications, items: 5
  end

  private

  def mark_as_read
    current_user.notifications.unread.mark_as_read
  end
end
