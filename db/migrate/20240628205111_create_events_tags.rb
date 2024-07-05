class CreateEventsTags < ActiveRecord::Migration[7.1]
  def change
    create_table :events_tags do |t|
      t.references :event, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps

      t.index %i[event_id tag_id], unique: true
    end
  end
end
