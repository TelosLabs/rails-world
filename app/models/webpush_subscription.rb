# == Schema Information
#
# Table name: webpush_subscriptions
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
#  index_webpush_subscriptions_on_user_id  (user_id)
#
class WebpushSubscription < ApplicationRecord
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
        public_key: Rails.application.credentials.dig(:vapid, :public_key),
        private_key: Rails.application.credentials.dig(:vapid, :private_key)
      }
    )
  end
end
