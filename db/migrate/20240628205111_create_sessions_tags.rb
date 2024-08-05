class CreateSessionsTags < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions_tags do |t|
      t.references :session, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps

      t.index %i[session_id tag_id], unique: true
    end
  end
end
