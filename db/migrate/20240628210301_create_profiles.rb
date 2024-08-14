class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :uuid, null: false
      t.text :bio
      t.string :job_title
      t.string :github_url
      t.string :linkedin_url
      t.string :twitter_url
      t.boolean :mail_notifications, default: true, null: false
      t.boolean :in_app_notifications, default: false, null: false
      t.boolean :is_public, default: false, null: false
      t.references :profileable, polymorphic: true, null: false

      t.timestamps

      t.index :uuid, unique: true
    end
  end
end
