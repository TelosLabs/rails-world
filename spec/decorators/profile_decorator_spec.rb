require "rails_helper"

RSpec.describe ProfileDecorator do
  let(:profile) { create(:profile, :with_user) }

  describe "#svg_qr_code" do
    it "generates a QR code SVG" do
      expect(profile.svg_qr_code).to include("<svg")
    end
  end

  describe "#png_qr_code" do
    it "generates a QR code PNG" do
      expect(profile.png_qr_code).to be_a(ChunkyPNG::Image)
    end
  end
end
