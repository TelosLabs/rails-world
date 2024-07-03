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
        expect { post :create, params: params }.to change { ActionMailer::Base.deliveries.count }.by(1)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #edit" do
    let(:current) { instance_double(Current) }

    before do
      allow(Current).to receive(:user).and_return(user)
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
        expect(response).to redirect_to(new_password_reset_path(alert: I18n.t("controllers.password_resets.errors.invalid_token")))
      end
    end
  end

  describe "PUT #update" do
    let(:new_password) { "new_password" }
    let(:current) { instance_double(Current) }

    before do
      allow(Current).to receive(:user).and_return(user)
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
        expect(response).to redirect_to(new_session_path)
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
        expect(response).to redirect_to(new_password_reset_path(alert: I18n.t("controllers.password_resets.errors.invalid_token")))
      end
    end
  end
end
