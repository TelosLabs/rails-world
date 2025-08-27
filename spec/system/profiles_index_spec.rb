# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Profiles Index", type: :system do
  let(:user) { create(:user, :with_profile) }

  describe "viewing attendees list" do
    context "when public profiles exist" do
      let!(:public_profiles) do
        profiles = []
        15.times do |i|
          profiles << create(:profile, :public, :with_user,
            name: "Public User #{i + 1}",
            job_title: "Developer #{i + 1}",
            created_at: i.hours.ago)
        end
        profiles
      end
      let!(:private_profile) do
        create(:profile, :with_user,
          name: "Private User",
          job_title: "Secret Developer")
      end

      it "displays only public profiles" do
        visit profiles_path

        expect(page).to have_content("Attendees")
        expect(page).to have_selector('[data-test-id="profile-card"]', count: 10)

        # Profiles are ordered by created_at DESC, so newest first (Public User 1)
        # The first 10 profiles (User 1-10) should be visible
        visible_profiles = public_profiles.first(10)
        visible_profiles.each do |profile|
          expect(page).to have_content(profile.name)
        end

        expect(page).not_to have_content(private_profile.name)
      end

      it "supports infinite scroll pagination" do
        visit profiles_path

        expect(page).to have_selector('[data-test-id="profile-card"]', count: 10)

        loader = find('[data-test-id="loader"]')
        page.execute_script("arguments[0].scrollIntoView(true);", loader)
        
        expect(page).to have_selector('[data-test-id="profile-card"]', minimum: 11)
      end

      it "navigates to profile when clicking on name" do
        visit profiles_path

        # The most recently created profile (Public User 1) will be first on the page
        profile = public_profiles.first
        within(find('[data-test-id="profile-card"]', match: :first)) do
          click_link profile.name
        end

        expect(page).to have_current_path(profile_path(profile.uuid))
      end

      it "displays profile images and job titles" do
        visit profiles_path

        within(find('[data-test-id="profile-card"]', match: :first)) do
          expect(page).to have_selector('img')
          # The most recently created profile (Public User 1) will be first
          expect(page).to have_content(public_profiles.first.job_title)
        end
      end
    end

    context "when no public profiles exist" do
      let!(:private_profiles) { create_list(:profile, 3, :with_user) }

      it "shows empty state" do
        visit profiles_path

        expect(page).to have_content("Attendees")
        expect(page).not_to have_selector('[data-test-id="profile-card"]')
      end
    end

    context "when user is authenticated" do
      before do
        sign_in(user)
      end

      it "allows access to profiles index" do
        create(:profile, :public, :with_user, name: "Test Attendee")
        
        visit profiles_path

        expect(page).to have_content("Attendees")
        expect(page).to have_content("Test Attendee")
        expect(page).to have_current_path(profiles_path)
      end
    end

    context "when user is not authenticated" do
      it "allows access to profiles index without login" do
        create(:profile, :public, :with_user, name: "Public Attendee")
        
        visit profiles_path

        expect(page).to have_content("Attendees")
        expect(page).to have_content("Public Attendee")
        expect(page).to have_current_path(profiles_path)
      end
    end

    context "with mixed public and private profiles" do
      let!(:public_profiles) do
        [
          create(:profile, :public, :with_user, name: "Alice Public"),
          create(:profile, :public, :with_user, name: "Bob Public"),
          create(:profile, :public, :with_user, name: "Charlie Public")
        ]
      end
      let!(:private_profiles) do
        [
          create(:profile, :with_user, name: "David Private"),
          create(:profile, :with_user, name: "Eve Private")
        ]
      end

      it "filters out private profiles from the listing" do
        visit profiles_path

        expect(page).to have_content("Alice Public")
        expect(page).to have_content("Bob Public")
        expect(page).to have_content("Charlie Public")
        expect(page).not_to have_content("David Private")
        expect(page).not_to have_content("Eve Private")

        expect(page).to have_selector('[data-test-id="profile-card"]', count: 3)
      end
    end
  end

end