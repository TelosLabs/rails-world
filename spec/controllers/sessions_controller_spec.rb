# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController, type: :controller do
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
        assigns(:user).should eq(user)
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
        expect(response).to have_http_status(:unprocessable_content)
        expect(response).to render_template(:new)
      end
    end
  end
end
