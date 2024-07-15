class QRCodeGenerator
  def initialize(url)
    @url = url
  end

  def as_svg(options = {})
    qr.as_svg(options)
  end

  def as_png(options = {})
    qr.as_png(options)
  end

  private

  attr_reader :url

  def qr
    @_qr ||= RQRCode::QRCode.new(url)
  end
end
