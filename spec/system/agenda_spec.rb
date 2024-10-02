require "rails_helper"

RSpec.describe "Agenda", type: :system do
  let!(:user) { create(:user) }
  let(:conference) { create(:conference) }
  let!(:session) { create(:session, :live, :with_speakers, conference: conference) }
  let(:speaker) { session.speakers.first }

  before do
    Timecop.freeze(Time.current.change(hour: 12))
  end

  context "when user is logged in" do
    before do
      sign_in(user)
    end

    it "allows to add and remove sessions to their schedule" do
      visit sessions_path

      find("#bookmark_session_#{session.id}").click
      expect(user.sessions).to include(session)

      find("#bookmark_session_#{session.id}").click
      expect(user.sessions).not_to include(session)
    end

    it "allows user to navigate to session details" do
      visit sessions_path

      find("#session_#{session.id}").click
      expect(page).to have_current_path(session_path(session))
      expect(page).to have_content(session.title)
      expect(page).to have_content(session.description.to_plain_text)
    end

    it "allows user to navigate to speaker details" do
      visit sessions_path

      find_dti("speaker_#{speaker.id}").click
      expect(page).to have_current_path(speaker_path(speaker.friendly_id))
      expect(page).to have_content(speaker.name)
      expect(page).to have_content(speaker.bio)
    end

    context "when filtering sessions" do
      let!(:past_session) { create(:session, :past, conference: conference) }
      let!(:live_session) { session }
      let!(:starting_soon_session) { create(:session, :starting_soon, conference: conference) }

      it "allows user to filter by date" do
        visit sessions_path

        find_dti("date_filter_#{live_session.starts_at.strftime("%a_%d")}").click
        expect(page).to have_content(live_session.title)
        expect(page).to have_content(starting_soon_session.title)
        expect(page).to have_no_content(past_session.title)

        find_dti("date_filter_#{past_session.starts_at.strftime("%a_%d")}").click
        expect(page).to have_content(past_session.title)
        expect(page).to have_no_content(live_session.title)
        expect(page).to have_no_content(starting_soon_session.title)

        find_dti("date_filter_all").click
        expect(page).to have_content(past_session.title)
        expect(page).to have_content(live_session.title)
        expect(page).to have_content(starting_soon_session.title)
      end

      it "allows user to filter by status" do
        visit sessions_path

        # Filter by live
        find_dti("session_status_filters").click
        find_by_id("live").click
        find_dti("session_status_filters_submit").click

        expect(page).to have_no_content(past_session.title)
        expect(page).to have_content(live_session.title)
        expect(page).to have_no_content(starting_soon_session.title)

        visit sessions_path

        # Filter by starting soon
        find_dti("session_status_filters").click
        find_by_id("starting_soon").click
        find_dti("session_status_filters_submit").click

        expect(page).to have_content(starting_soon_session.title)
        expect(page).to have_no_content(live_session.title)
        expect(page).to have_no_content(past_session.title)

        visit sessions_path

        # Filter by past
        find_dti("session_status_filters").click
        find_by_id("past").click
        find_dti("session_status_filters_submit").click

        expect(page).to have_content(past_session.title)
        expect(page).to have_no_content(live_session.title)
        expect(page).to have_no_content(starting_soon_session.title)
      end
    end
  end

  context "when user is not logged in" do
    it "redirects user to login" do
      visit sessions_path

      find("#bookmark_session_#{session.id}").click
      expect(page).to have_current_path(new_user_session_path)
    end

    it "allows user to navigate to session details" do
      visit sessions_path

      find("#session_#{session.id}").click
      expect(page).to have_current_path(session_path(session))
      expect(page).to have_content(session.title)
      expect(page).to have_content(session.description.to_plain_text)
    end

    it "allows user to navigate to speaker details" do
      visit sessions_path

      find_dti("speaker_#{speaker.id}").click
      expect(page).to have_current_path(speaker_path(speaker.friendly_id))
      expect(page).to have_content(speaker.name)
      expect(page).to have_content(speaker.bio)
    end

    context "when opening a private sessions" do
      let!(:private_session) { create(:session, conference: conference, public: false) }

      it "does not show private sessions" do
        visit session_path(private_session.id)

        expect(page).to have_current_path(new_user_session_path, ignore_query: true)
      end
    end
  end
end
