class DeliveryMethods::Webpush < ApplicationDeliveryMethod
  def deliver
    recipient.webpush_subscriptions.each do |sub|
      WebPush.payload_send(
        message: "Hello world",
        endpoint: sub.endpoint,
        p256dh: sub.p256dh,
        auth: sub.auth,
        vapid: {
          subject: "sender@example.com",
          public_key: Rails.application.credentials.dig(:vapid, :public_key),
          private_key: Rails.application.credentials.dig(:vapid, :private_key)
        }
      )
    end
  end
end
