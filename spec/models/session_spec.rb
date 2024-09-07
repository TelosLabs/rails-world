# == Schema Information
#
# Table name: sessions
#
#  id             :integer          not null, primary key
#  ends_at        :datetime         not null
#  public         :boolean          default(TRUE), not null
#  sent_reminders :json
#  slug           :string
#  starts_at      :datetime         not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  conference_id  :integer          not null
#  location_id    :integer          not null
#
# Indexes
#
#  index_sessions_on_conference_id  (conference_id)
#  index_sessions_on_ends_at        (ends_at)
#  index_sessions_on_location_id    (location_id)
#  index_sessions_on_slug           (slug) UNIQUE
#  index_sessions_on_starts_at      (starts_at)
#
require "rails_helper"

RSpec.describe Session, type: :model do
  let(:session) { build(:session) }

  it "has a valid factory" do
    expect(session).to be_valid
  end

  describe "validations" do
    it "needs to have starts_at set before ends_at" do
      expect(session).to be_valid
      session.starts_at = 1.day.from_now
      session.ends_at = 1.day.ago
      expect(session).not_to be_valid
    end
  end
end
