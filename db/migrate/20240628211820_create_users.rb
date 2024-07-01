class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :role
      t.boolean :mail_notifications_enabled, default: true
      t.boolean :in_app_notifications_enabled, default: true

      t.timestamps
    end
  end
end
