class AddReminderDetailsToSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :sessions, :reminder_details, :jsonb, default: {}
  end
end
