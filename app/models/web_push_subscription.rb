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
