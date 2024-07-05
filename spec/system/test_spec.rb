require "rails_helper"

RSpec.describe "System specs health check", type: :system do
  it "website is up" do
    visit "/up"
    expect(page).to have_http_status(:ok)
  end
end
