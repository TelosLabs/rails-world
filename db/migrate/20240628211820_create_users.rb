class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :role
      t.boolean :mail_notifications, default: true, null: false
      t.boolean :in_app_notifications, default: true, null: false
      t.string :password_digest, null: false

      t.timestamps

      t.index :email, unique: true
    end
  end
end
