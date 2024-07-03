class AddIndexToUserEmail < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :email, unique: true
  end
end
