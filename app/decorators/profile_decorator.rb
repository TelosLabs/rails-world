class ProfileDecorator < Draper::Decorator
  delegate_all

  def svg_qr_code(options = {})
    url = Rails.application.routes.url_helpers.profile_url(object, host: ENV["APP_HOST"])
    RQRCode::QRCode.new(url).as_svg(options)
  end
end
