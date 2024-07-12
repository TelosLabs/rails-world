# frozen_string_literal: true

require "rails_helper"

RSpec.describe PasswordsController, type: :controller do
  let!(:user) { create(:user, password: "password") }

  before do
    sign_in(user)
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT #update" do
    let(:new_password) { "new_password" }

    context "with valid params" do
      let(:params) do
        {
          user: {
            password: new_password,
            password_confirmation: new_password,
            password_challenge: "password"
          }
        }
      end

      it "resets user password" do
        expect { put :update, params: params }.to change { user.reload.authenticate(new_password) }.from(false).to(user)
        expect(response).to redirect_to(edit_password_path)
      end
    end

    context "with invalid params" do
      let(:params) do
        {
          user: {
            password: "password",
            password_confirmation: "password",
            password_challenge: "wrong_password"
          }
        }
      end

      it "does not update the user password" do
        expect { put :update, params: params }.not_to change { user.reload.password_digest }
        expect(response).to have_http_status(:unprocessable_content)
        expect(response).to render_template(:edit)
      end
    end
  end
end
