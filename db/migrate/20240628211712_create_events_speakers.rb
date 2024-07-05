class CreateEventsSpeakers < ActiveRecord::Migration[7.1]
  def change
    create_table :events_speakers do |t|
      t.references :event, null: false, foreign_key: true
      t.references :speaker, null: false, foreign_key: true

      t.index %i[event_id speaker_id], unique: true
    end
  end
end
