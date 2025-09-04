# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserSessionsController, type: :controller do
  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    let!(:user) { create(:user, password: "password") }

    context "with valid params" do
      let(:params) do
        {
          user: {
            email: user.email,
            password: "password"
          }
        }
      end

      it "creates a User session" do
        post :create, params: params
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      let(:params) do
        {
          user: {
            email: user.email,
            password: "invalid_password"
          }
        }
      end

      it "does not create a User session" do
        expect { post :create, params: params }.not_to change(User, :count)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "with rate limit" do
      before do
        Rails.application.config.action_controller.perform_caching = true
      end

      after do
        Rails.cache.clear
      end

      let(:params) do
        {
          user: {
            email: user.email,
            password: "invalid_password"
          }
        }
      end

      it "rate limits a request after 3 attempts under a minute" do
        3.times do |_|
          expect { post :create, params: params }.not_to change(User, :count)
          expect(response).to redirect_to(new_user_session_path)
        end

        post :create, params: params

        expect { post :create, params: params }.not_to change(User, :count)
        expect(response).to have_http_status(:too_many_requests)
      end
    end
  end
end
