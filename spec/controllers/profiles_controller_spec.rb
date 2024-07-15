# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProfilesController, type: :controller do
  let(:profile) { create(:profile, :with_user, :public) }

  before do
    sign_in(profile.user)
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: {uuid: profile.uuid}
      expect(response).to have_http_status(:success)
    end

    context "when the profile is not public" do
      let(:profile) { create(:profile, :with_user, is_public: false) }

      it "returns a not found response" do
        get :show, params: {uuid: profile.uuid}
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET #qr_code" do
    it "returns a PNG" do
      get :qr_code, params: {uuid: profile.uuid}
      expect(response.headers["Content-Type"]).to eq("image/png")
      expect(response.headers["Content-Disposition"]).to include("#{profile.name}.png")
    end
  end
end
