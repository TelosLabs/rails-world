class CreateEventsUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :events_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps

      t.index %i[user_id event_id], unique: true
    end
  end
end
