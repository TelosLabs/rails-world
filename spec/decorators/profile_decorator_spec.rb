require "rails_helper"

RSpec.describe ProfileDecorator do
  let(:profile) { create(:profile, :with_user).decorate }

  describe "#svg_qr_code" do
    it "generates a QR code SVG" do
      expect(profile.svg_qr_code).to include("<svg")
    end
  end
end
