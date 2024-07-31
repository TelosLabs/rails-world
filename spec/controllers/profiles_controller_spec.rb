# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProfilesController, type: :controller do
  let(:user) { create(:user, :with_profile) }
  let(:profile) { user.profile }
  let(:other_profile) { create(:profile, :with_user) }

  before do
    sign_in(user)
  end

  describe "GET #show" do
    context "when the profile is yourself" do
      it "returns a success response" do
        get :show, params: {uuid: profile.uuid}
        expect(response).to have_http_status(:success)
      end
    end

    context "when the profile is public" do
      before do
        other_profile.update!(is_public: true)
      end

      it "returns a success response" do
        get :show, params: {uuid: other_profile.uuid}
        expect(response).to have_http_status(:success)
      end
    end

    context "when the profile is not public" do
      it "redirects to the root path" do
        get :show, params: {uuid: other_profile.uuid}
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
