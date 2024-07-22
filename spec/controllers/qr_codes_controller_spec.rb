# frozen_string_literal: true

require "rails_helper"

RSpec.describe QRCodesController, type: :controller do
  let(:profile) { create(:profile, :with_user, :public) }

  before do
    sign_in(profile.user)
  end

  describe "GET #show" do
    it "returns a PNG" do
      get :show, params: {profile_uuid: profile.uuid}
      expect(response.headers["Content-Type"]).to eq("image/png")
      expect(response.headers["Content-Disposition"]).to include("#{profile.name}.png")
    end
  end
end
