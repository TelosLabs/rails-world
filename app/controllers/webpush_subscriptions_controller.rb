class WebpushSubscriptionsController < ApplicationController
  def create
    webpush_subscription = WebpushSubscription.find_or_initialize_by(
      endpoint: params[:endpoint],
      p256dh: params.dig(:keys, :p256dh),
      auth: params.dig(:keys, :auth),
      user_id: current_user.id
    )

    if webpush_subscription.save
      render json: webpush_subscription, status: :created
    else
      render json: webpush_subscription.errors, status: :unprocessable_entity
    end
  end
end
