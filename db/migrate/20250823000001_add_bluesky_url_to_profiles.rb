class AddBlueskyUrlToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :bluesky_url, :string
  end
end