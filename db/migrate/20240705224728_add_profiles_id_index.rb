class AddProfilesIdIndex < ActiveRecord::Migration[7.1]
  def change
    add_index :profiles, %w[id], name: :index_profiles_id, unique: true
  end
end
