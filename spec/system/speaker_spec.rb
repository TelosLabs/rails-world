require "rails_helper"

RSpec.describe "Speaker", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  context "when speaker has social links" do
    let(:session) { create(:session, :with_speakers) }
    let(:speaker) { session.speakers.first }

    it "displays social links" do
      visit speaker_path(speaker)

      expect(page).to have_link(href: "https://github.com")
      expect(page).to have_link(href: "https://twitter.com")
      expect(page).to have_link(href: "https://linkedin.com")
    end
  end

  context "when speaker does not have social links" do
    let(:session) { create(:session) }
    let(:speaker) { create(:speaker, :with_no_social_links, sessions: [session]) }

    it "does not display social links" do
      visit speaker_path(speaker)

      expect(page).to have_no_link(href: "https://github.com")
      expect(page).to have_no_link(href: "https://twitter.com")
      expect(page).to have_no_link(href: "https://linkedin.com")
    end
  end
end
