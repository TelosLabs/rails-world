require "rails_helper"

RSpec.describe EventReminderJob, type: :job do
  let(:conference) { create(:conference) }
  let(:location) { create(:location, conference: conference) }
  let(:user) { create(:user) }
  let(:now) { Time.zone.now }

  before do
    Timecop.freeze(now)
  end

  after do
    Timecop.return
  end

  it "delivers notifications on schedule" do
    event_starting_times = ["7:00", "8:18", "9:50", "10:01", "12:59", "14:15", "15:33", "16:00", "17:30", "18:11"]

    events = event_starting_times.map do |time|
      starts_at = Time.zone.parse(time)
      event = create(:event, conference: conference, location: location, starts_at: starts_at, ends_at: starts_at + 30.minutes)
      event.users << user
      event
    end

    events.each do |event|
      Event::REMINDER_CADENCE.each do |reminder_type, cadence|
        Timecop.travel(event.starts_at - cadence)

        expect {
          described_class.perform_now
        }.to change {
          Noticed::Notification.joins(:event).where(noticed_events: {record: event}, recipient: user).count
        }.by(1)

        nots = Noticed::Notification.joins(:event).where(noticed_events: {record: event}, recipient: user)
        expect(nots.last.params[:reminder_type]).to eq(reminder_type)
      end
    end
  end
end
