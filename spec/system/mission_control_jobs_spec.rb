require "rails_helper"

RSpec.describe "Mission Control Jobs UI", type: :system do
  it do
    visit "/jobs"
    expect(page).to have_current_path("/user_session/new")
  end

  context "when authenticated" do
    let(:user) { create(:user) }

    before { sign_in(user) }

    it "redirects to the root path" do
      visit "/jobs"
      expect(page).to have_current_path(root_path)
    end

    context "with an admin account" do
      let(:user) { create(:user, :admin) }

      it "shows Mission Control Jobs UI" do
        visit "/jobs"
        expect(page).to have_current_path("/jobs")
      end
    end
  end
end
