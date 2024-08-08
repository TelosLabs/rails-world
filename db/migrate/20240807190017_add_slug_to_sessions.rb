class AddSlugToSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :sessions, :slug, :string
    add_index :sessions, :slug, unique: true
  end
end
