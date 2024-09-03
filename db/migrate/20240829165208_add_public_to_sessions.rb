class AddPublicToSessions < ActiveRecord::Migration[7.2]
  def change
    add_column :sessions, :public, :boolean, default: true, null: false
  end
end
