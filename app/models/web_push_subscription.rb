# == Schema Information
#
# Table name: web_push_subscriptions
#
#  id         :integer          not null, primary key
#  auth       :string           not null
#  endpoint   :string           not null
#  p256dh     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_web_push_subscriptions_on_user_id  (user_id)
#
class WebPushSubscription < ApplicationRecord
  belongs_to :user

  validates :auth, presence: true
  validates :endpoint, presence: true
  validates :p256dh, presence: true

  def publish(data)
    WebPush.payload_send(
      message: data.to_json,
      endpoint: endpoint,
      p256dh: p256dh,
      auth: auth,
      vapid: {
        public_key: ENV["VAPID_PUBLIC_KEY"],
        private_key: ENV["VAPID_PRIVATE_KEY"]
      }
    )
  end
end
