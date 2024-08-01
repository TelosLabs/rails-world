class CreateSessionsSpeakers < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions_speakers do |t|
      t.references :session, null: false, foreign_key: true
      t.references :speaker, null: false, foreign_key: true

      t.timestamps

      t.index %i[session_id speaker_id], unique: true
    end
  end
end
