require "rails_helper"

RSpec.describe "Schedule", type: :system do
  let!(:user) { create(:user) }
  let!(:session) { create(:session, :live, :with_speakers) }
  let(:speaker) { session.speakers.first }

  context "when user is logged in" do
    before do
      sign_in(user)
      user.sessions << session
    end

    it "allows to see and remove sessions from their schedule" do
      visit schedule_path
      expect(page).to have_content(session.title)

      find_dti("bookmark_session_#{session.id}").click
      expect(user.sessions).not_to include(session)
      expect(page).to have_no_content(session.title)
    end

    it "allows user to navigate to session details" do
      visit schedule_path

      find_dti("schedule_session_#{session.id}").click
      expect(page).to have_current_path(session_path(session))
      expect(page).to have_content(session.title)
      expect(page).to have_content(session.description.to_plain_text)
    end

    it "allows user to navigate to speaker details" do
      visit schedule_path

      find_dti("speaker_#{speaker.id}").click
      expect(page).to have_current_path(speaker_path(speaker.friendly_id))
      expect(page).to have_content(speaker.name)
      expect(page).to have_content(speaker.bio)
    end
  end

  context "when user is not logged in" do
    it "redirects user to login" do
      visit schedule_path
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
