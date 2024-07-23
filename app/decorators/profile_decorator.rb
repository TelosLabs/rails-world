class ProfileDecorator < Draper::Decorator
  delegate_all

  def svg_qr_code(options = {})
    RQRCode::QRCode.new(profile_url).as_svg(options)
  end

  def png_qr_code(options = {})
    RQRCode::QRCode.new(profile_url).as_png(options)
  end

  private

  def profile_url
    Rails.application.routes.url_helpers.profile_url(object.uuid)
  end
end
