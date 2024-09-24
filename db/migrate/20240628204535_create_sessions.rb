class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.string :title, null: false
      t.string :description
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.json :sent_reminders, default: []
      t.references :location, null: false, foreign_key: true
      t.references :conference, null: false, foreign_key: true

      t.timestamps
    end
  end
end
