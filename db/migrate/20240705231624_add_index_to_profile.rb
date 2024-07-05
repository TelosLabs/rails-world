class AddIndexToProfile < ActiveRecord::Migration[7.1]
  def change
    add_index :profiles, :id, unique: true
  end
end
