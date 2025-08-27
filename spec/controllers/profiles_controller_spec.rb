# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProfilesController, type: :controller do
  let(:user) { create(:user, :with_profile) }
  let(:profile) { user.profile }
  let(:other_profile) { create(:profile, :with_user) }

  before do
    sign_in(user)
  end

  describe "GET #index" do
    context "when there are public profiles" do
      let!(:public_profiles) { create_list(:profile, 15, :public, :with_user) }
      let!(:private_profiles) { create_list(:profile, 5, :with_user) }

      before do
        profile.update!(is_public: true)
      end

      it "returns a success response" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns only public profiles" do
        get :index
        expect(assigns(:profiles).map(&:id)).not_to include(*private_profiles.map(&:id))
      end

      it "excludes the current user's profile when signed in" do
        get :index
        expect(assigns(:profiles).map(&:id)).not_to include(profile.id)
      end

      it "paginates results with 10 profiles per page" do
        get :index
        expect(assigns(:profiles).count).to eq(10)
      end

      it "returns second page of profiles" do
        get :index, params: {page: 2}
        expect(assigns(:profiles).count).to eq(5)
      end

      it "responds to turbo_stream format" do
        get :index, params: {page: 2}, format: :turbo_stream
        expect(response).to have_http_status(:success)
        expect(response.content_type).to include("text/vnd.turbo-stream.html")
      end
    end

    context "when there are no public profiles" do
      let!(:private_profiles) { create_list(:profile, 3, :with_user) }

      it "returns a success response with empty collection" do
        get :index
        expect(response).to have_http_status(:success)
        expect(assigns(:profiles)).to be_empty
      end
    end

    context "when not authenticated" do
      before do
        session[:user_id] = nil
      end

      let!(:public_profiles) { create_list(:profile, 3, :public, :with_user) }

      it "still allows access to index page" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "includes all public profiles when not signed in" do
        get :index
        expect(assigns(:profiles).count).to eq(3)
        expect(assigns(:profiles).map(&:id)).to match_array(public_profiles.map(&:id))
      end
    end
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
