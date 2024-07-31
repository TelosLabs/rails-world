# == Schema Information
#
# Table name: webpush_subscriptions
#
#  id         :integer          not null, primary key
#  auth       :string
#  endpoint   :string
#  p256dh     :string
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
end
