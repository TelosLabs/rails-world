class CreateWebpushSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :webpush_subscriptions do |t|
      t.string :endpoint
      t.string :p256dh
      t.string :auth
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
