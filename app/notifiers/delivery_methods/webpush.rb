class DeliveryMethods::Webpush < Noticed::DeliveryMethod
  def deliver
    recipient.webpush_subscriptions.each do |sub|
      WebPush.payload_send(
        message: JSON.generate(evaluate_option(:payload_message)),
        endpoint: sub.endpoint,
        p256dh: sub.p256dh,
        auth: sub.auth,
        vapid: {
          public_key: Rails.application.credentials.dig(:vapid, :public_key),
          private_key: Rails.application.credentials.dig(:vapid, :private_key)
        }
      )
    end
  end
end
