class DeliveryMethods::CustomEmail < Noticed::DeliveryMethods::Email
  def deliver
    super
  rescue RuntimeError => e
    Rails.logger.error("Mailpace error: #{e.message}")
  end
end
