class WebPushSubscriptionsController < ApplicationController
  def create
    web_push_subscription = WebPushSubscription.find_or_initialize_by(
      endpoint: params[:endpoint],
      p256dh: params.dig(:keys, :p256dh),
      auth: params.dig(:keys, :auth),
      user_id: current_user.id
    )

    if web_push_subscription.save
      render json: web_push_subscription, status: :created
    else
      render json: web_push_subscription.errors, status: :unprocessable_entity
    end
  end
end
