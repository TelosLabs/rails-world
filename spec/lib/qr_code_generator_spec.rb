# frozen_string_literal: true

require "rails_helper"

RSpec.describe QRCodeGenerator do
  let(:qr_code_generator) { described_class.new(Faker::Internet.url) }

  describe "#as_svg" do
    it "returns an SVG" do
      expect(qr_code_generator.as_svg).to include("<svg")
    end
  end

  describe "#as_png" do
    it "returns a PNG" do
      expect(qr_code_generator.as_png.to_s).to include("PNG")
    end
  end
end
