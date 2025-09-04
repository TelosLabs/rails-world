# frozen_string_literal: true

require "rails_helper"

RSpec.describe PasswordResetsController, type: :controller do
  let!(:user) { create(:user, password: "password") }
  let(:user_token) { user.generate_token_for(:password_reset) }

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:params) do
        {
          email: user.email
        }
      end

      it "sends a password reset email" do
        expect {
          post :create, params: params
        }.to have_enqueued_mail(PasswordMailer, :password_reset)
        expect(response).to redirect_to(post_submit_password_reset_path)
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
          email: user.email
        }
      end

      it "allows up to 3 requests within 1 minute" do
        3.times do |i|
          @request.env["REMOTE_ADDR"] = "192.168.1.100"
          post :create, params: params
          expect(response).to redirect_to(post_submit_password_reset_path)
        end
      end

      it "blocks the 4th request" do
        3.times do
          @request.env["REMOTE_ADDR"] = "192.168.1.100"
          post :create, params: params
          expect(response).to redirect_to(post_submit_password_reset_path)
        end

        @request.env["REMOTE_ADDR"] = "192.168.1.100"
        post :create, params: params
        
        expect(flash[:alert]).to eq("Please try again later.")
        expect(response).to have_http_status(:too_many_requests)
      end
    end
  end

  describe "GET #edit" do
    before do
      sign_in(user)
    end

    context "with valid token" do
      it "returns a success response" do
        get :edit, params: {token: user_token}
        expect(response).to have_http_status(:ok)
        expect(assigns(:user)).to eq(user)
      end
    end

    context "with invalid token" do
      it "redirects to new password reset path" do
        get :edit, params: {token: "invalid_token"}
        expect(response).to redirect_to(new_password_reset_path)
      end
    end
  end

  describe "PUT #update" do
    let(:new_password) { "new_password" }

    before do
      sign_in(user)
    end

    context "with valid params" do
      let(:params) do
        {
          user: {
            password: new_password,
            password_confirmation: new_password
          },
          token: user_token
        }
      end

      it "resets user password" do
        expect { put :update, params: params }
          .to change { user.reload.authenticate(new_password) }.from(false).to(user)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "with invalid params" do
      let(:params) do
        {
          user: {
            password: "password",
            password_confirmation: "wrong_password"
          },
          token: user_token
        }
      end

      it "does not update the user password" do
        expect { put :update, params: params }.not_to change { user.reload.password_digest }
        expect(response).to have_http_status(:unprocessable_content)
        expect(response).to render_template(:edit)
      end
    end

    context "with invalid token" do
      let(:params) do
        {
          user: {
            password: "password",
            password_confirmation: "password"
          },
          token: "invalid_token"
        }
      end

      it "does not update the user password" do
        expect { put :update, params: params }.not_to change { user.reload.password_digest }
        expect(response).to redirect_to(new_password_reset_path)
      end
    end
  end
end
