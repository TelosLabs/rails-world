class AddReminderDetailsToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :reminder_details, :jsonb, default: {}
  end
end
