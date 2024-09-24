require "rails_helper"

RSpec.describe "User sign in", type: :system do
  let!(:user) { create(:user, email: "test@test.com", password: "foobar2024") }

  it "redirects to the login page when trying to access another page" do
    visit edit_password_path
    expect(page).to have_current_path(new_user_session_path)
  end

  context "when the user inputs invalid credentials" do
    it "does not sign the user in" do
      visit new_user_session_path
      find_dti("email_field").set("test@test.com")
      find_dti("password_field").set("wrongpassword")
      find_dti("sign_in_button").click
      expect(page).to have_content("Invalid email or password.")

      visit edit_password_path
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context "when the user inputs valid credentials" do
    it "signs the user in" do
      visit new_user_session_path
      find_dti("email_field").set("test@test.com")
      find_dti("password_field").set("foobar2024")
      find_dti("sign_in_button").click

      visit edit_password_path
      expect(page).to have_current_path(edit_password_path)
    end
  end
end
