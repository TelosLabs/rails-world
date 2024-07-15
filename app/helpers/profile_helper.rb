module ProfileHelper
  def qr_code_svg(profile)
    QRCodeGenerator.new(profile_url(profile.uuid)).as_svg(module_size: 4)
  end

  def qr_code_png(profile)
    QRCodeGenerator.new(profile_url(profile.uuid)).as_png(size: 240)
  end
end
