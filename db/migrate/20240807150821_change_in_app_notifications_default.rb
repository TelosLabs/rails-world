class ChangeInAppNotificationsDefault < ActiveRecord::Migration[7.1]
  def change
    change_column_default :profiles, :in_app_notifications, from: true, to: false
  end
end
