# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProfileHelper, type: :helper do
  describe "#qr_code_svg" do
    let(:profile) { create(:profile, :with_user) }

    it "generates a QR code SVG" do
      expect(helper.qr_code_svg(profile)).to include("<svg")
    end
  end
end
