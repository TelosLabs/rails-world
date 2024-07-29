# frozen_string_literal: true

require "rails_helper"

RSpec.describe RegistrationsController, type: :controller do
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
          user: {
            email: "dev@example.com",
            password: "password",
            password_confirmation: "password"
          }
        }
      end

      it "creates a new User" do
        expect { post :create, params: params }.to change(User, :count).by(1)
        expect(session[:user_id]).to eq(User.last.id)
        expect(response).to redirect_to(edit_profile_path)
      end
    end

    context "with invalid params" do
      let(:params) { {user: {email: ""}} }

      it "does not create a new User" do
        expect { post :create, params: params }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_content)
        expect(response).to render_template(:new)
      end
    end
  end
end
