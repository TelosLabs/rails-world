class CreateSessionsUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :session, null: false, foreign_key: true

      t.timestamps

      t.index %i[user_id session_id], unique: true
    end
  end
end
