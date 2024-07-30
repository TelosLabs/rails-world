class AddProfileUuidToProfile < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :uuid, :string
    add_index :profiles, :uuid, unique: true
  end
end
