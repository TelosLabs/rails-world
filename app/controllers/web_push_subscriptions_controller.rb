class WebPushSubscriptionsController < ApplicationController
  def create
    web_push_subscription = WebPushSubscription.find_or_initialize_by(
      endpoint: params[:endpoint],
      p256dh: params.dig(:keys, :p256dh),
      auth: params.dig(:keys, :auth),
      user_id: current_user.id
    )

    web_push_subscription.save!
  end
end
