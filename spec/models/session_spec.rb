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
  let(:live_session) { create(:session, :live) }
  let(:starting_soon_session) { create(:session, :starting_soon) }
  let(:past_session) { create(:session, :past) }

  before do
    Timecop.freeze(Time.current.change(hour: 12))
  end

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

  describe "#live?" do
    it { expect(live_session).to be_live }

    context "when session has not started" do
      it "returns false" do
        allow(live_session).to receive_messages(starts_at: 1.hour.from_now, ends_at: 2.hours.from_now)
        expect(live_session).not_to be_live
      end
    end

    context "when session has already ended" do
      it "returns false" do
        allow(live_session).to receive_messages(starts_at: 2.hours.ago, ends_at: 1.hour.ago)
        expect(live_session).not_to be_live
      end
    end
  end

  describe "#starting_soon?" do
    it { expect(starting_soon_session).to be_starting_soon }

    context "when session has already started" do
      it "returns false" do
        allow(starting_soon_session).to receive(:starts_at).and_return(2.hours.ago)
        expect(starting_soon_session).not_to be_starting_soon
      end
    end

    context "when session starts in more than an hour" do
      it "returns false" do
        allow(starting_soon_session).to receive(:starts_at).and_return(2.hours.from_now)
        expect(starting_soon_session).not_to be_starting_soon
      end
    end
  end

  describe "#past?" do
    it { expect(past_session).to be_past }

    context "when session hasn't ended" do
      it "returns false" do
        allow(past_session).to receive(:ends_at).and_return(2.hours.from_now)
        expect(past_session).not_to be_past
      end
    end
  end
end
