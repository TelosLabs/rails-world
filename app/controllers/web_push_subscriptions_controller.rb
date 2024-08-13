class WebPushSubscriptionsController < ApplicationController
  def create
    WebPushSubscription.find_or_create_by!(endpoint: params[:endpoint]) do |subscription|
      subscription.p256dh = params.dig(:keys, :p256dh)
      subscription.auth = params.dig(:keys, :auth)
      subscription.user = current_user
    end

    head :ok
  end
end
