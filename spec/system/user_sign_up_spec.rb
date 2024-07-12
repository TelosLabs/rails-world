require "rails_helper"

RSpec.describe "User sign up", type: :system do
  before { visit new_registration_path }

  context "when the password & password confirmation doesn't match up" do
    it "does not create a new user" do
      find_dti("email_field").set("test@test.com")
      find_dti("password_field").set("hello")
      find_dti("password_confirmation_field").set("world")
      find_dti("sign_up_button").click

      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end

  context "when the email is already taken" do
    let!(:user) { create(:user, email: "test@test.com") }

    it "does not create a new user" do
      find_dti("email_field").set("test@test.com")
      find_dti("password_field").set("foobar2024")
      find_dti("password_confirmation_field").set("foobar2024")
      find_dti("sign_up_button").click

      expect(page).to have_content("Email has already been taken")
    end
  end

  context "when the password doesn't met the length criteria" do
    it "does not create a new user" do
      find_dti("email_field").set("test@test.com")
      find_dti("password_field").set("foobar")
      find_dti("password_confirmation_field").set("foobar")
      find_dti("sign_up_button").click

      expect(page).to have_content("Password is too short (minimum is 8 characters)")
    end
  end

  context "when the user inputs valid credentials" do
    it "creates a new user" do
      find_dti("email_field").set("test@test.com")
      find_dti("password_field").set("foobar2024")
      find_dti("password_confirmation_field").set("foobar2024")
      find_dti("sign_up_button").click

      visit edit_password_path
      expect(page).to have_current_path(edit_password_path)
    end
  end
end
