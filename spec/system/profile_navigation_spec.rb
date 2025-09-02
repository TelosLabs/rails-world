require "rails_helper"

RSpec.describe "Profile navigation", type: :system do
  let(:user) { create(:user, :with_profile) }
  let(:other_user) { create(:user, :with_profile, email: "other@example.com") }

  before do
    other_user.profile.update!(is_public: true, name: "Other User", job_title: "Developer")
    user.profile.update!(is_public: true, name: "Current User", job_title: "Designer")
  end

  describe "when signed in" do
    before do
      sign_in user
    end

    it "shows 'Attendees' in bottom navigation instead of 'Profile'" do
      visit sessions_path

      within ".fixed.bottom-0" do
        expect(page).to have_text("Attendees")
        expect(page).to have_no_text("Profile")
      end
    end

    it "displays current user's profile card at top of attendees page" do
      visit profiles_path

      # Check for current user profile card
      within "[data-test-id='my-profile-card']" do
        expect(page).to have_text("YOUR PROFILE")
        expect(page).to have_text("Current User")
        expect(page).to have_text("Designer")
        expect(page).to have_no_link("Edit Profile")
      end

      # Check that current user is not in the main list
      within "#profiles" do
        expect(page).to have_text("Other User")
        expect(page).to have_no_text("Current User")
      end
    end

    it "allows navigation to current user's profile from profile card" do
      visit profiles_path

      within "[data-test-id='my-profile-card']" do
        click_on "Current User"
      end

      expect(page).to have_current_path(profile_path(user.profile.uuid))
    end
  end

  describe "when not signed in" do
    it "shows 'Attendees' in bottom navigation" do
      visit sessions_path

      within ".fixed.bottom-0" do
        expect(page).to have_text("Attendees")
      end
    end

    it "displays profile setup prompt when not signed in" do
      visit profiles_path

      within "[data-test-id='my-profile-card']" do
        expect(page).to have_text("YOUR PROFILE")
        expect(page).to have_text("Set up your profile")
      end

      expect(page).to have_text("All Attendees")

      # Both users should be in the list when not signed in
      within "#profiles" do
        expect(page).to have_text("Other User")
        expect(page).to have_text("Current User")
      end
    end

    it "navigates to sign in when clicking profile setup link" do
      visit profiles_path

      within "[data-test-id='my-profile-card']" do
        click_on "Set up your profile"
      end

      expect(page).to have_current_path(new_user_session_path)
    end

    it "navigates to profiles index when clicking Attendees" do
      visit sessions_path

      within ".fixed.bottom-0" do
        click_on "Attendees"
      end

      expect(page).to have_current_path(profiles_path)
      expect(page).to have_text("All Attendees")
    end
  end
end
