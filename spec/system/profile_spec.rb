require "rails_helper"

RSpec.describe "Schedule", type: :system do
  let(:user) { create(:user) }
  let(:profile) { user.profile }

  context "when user is logged in" do
    before do
      sign_in(user)
    end

    it "allows user to update their profile" do
      visit profile_path(profile.uuid)

      expect(page).to have_no_css(dti("github_link"))
      expect(page).to have_no_css(dti("twitter_link"))
      expect(page).to have_no_css(dti("linkedin_link"))

      visit edit_profile_path(profile.uuid)

      find_by_id("profile_name").set("John Doe")
      find_by_id("profile_bio").set("Description about John Doe")
      find_by_id("profile_github_url").set("github.com/johndoe")
      find_by_id("profile_linkedin_url").set("linkedin.com/johndoe")
      find_by_id("profile_twitter_url").set("twitter.com/johndoe")
      find('[for="profile_is_public"]').click

      find_dti("save_profile_button").click

      expect(page).to have_content("John Doe")
      expect(page).to have_content("Description about John Doe")
      expect(page).to have_css(dti("github_link"))
      expect(page).to have_css(dti("twitter_link"))
      expect(page).to have_css(dti("linkedin_link"))
      expect(find_dti("qr_code")).to be_present
    end
  end
end
