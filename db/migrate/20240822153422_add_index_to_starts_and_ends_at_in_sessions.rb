class AddIndexToStartsAndEndsAtInSessions < ActiveRecord::Migration[7.2]
  def change
    add_index :sessions, :starts_at
    add_index :sessions, :ends_at
  end
end
