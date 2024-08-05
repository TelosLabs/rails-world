class DeliveryMethods::Webpush < Noticed::DeliveryMethod
  def deliver
    recipient.webpush_subscriptions.each do |subscription|
      subscription.publish(evaluate_option(:payload_message))
    rescue WebPush::ExpiredSubscription => e
      Rails.logger.error(e.message)
      subscription.destroy
    end
  end
end
