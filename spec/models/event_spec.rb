# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  description   :string
#  ends_at       :datetime         not null
#  starts_at     :datetime         not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  conference_id :integer          not null
#  location_id   :integer          not null
#
# Indexes
#
#  index_events_on_conference_id  (conference_id)
#  index_events_on_location_id    (location_id)
#
require "rails_helper"

RSpec.describe Event, type: :model do
  let(:event) { build_stubbed(:event, :with_conference, :with_location) }

  it "has a valid factory" do
    expect(event).to be_valid
  end

  describe "validations" do
    it "needs to have starts_at set before ends_at" do
      expect(event).to be_valid
      event.starts_at = 1.day.from_now
      event.ends_at = 1.day.ago
      expect(event).not_to be_valid
    end
  end
end
