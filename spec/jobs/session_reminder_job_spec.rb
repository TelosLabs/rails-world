require "rails_helper"

RSpec.describe SessionReminderJob, type: :job do
  let(:conference) { create(:conference) }
  let(:location) { create(:location, conference: conference) }
  let(:user) { create(:user) }
  let(:now) { Time.zone.now }

  before do
    ENV["SESSION_REMINDERS_ENABLED"] = "true"
    Timecop.freeze(now)
  end

  after do
    ENV["SESSION_REMINDERS_ENABLED"] = "false"
    Timecop.return
  end

  it "doesn't deliver the notification if the reminder window is yet to pass" do
    starts_at = Time.zone.parse("7:00")
    session = create(:session, conference: conference, location: location,
      starts_at: starts_at, ends_at: starts_at + 30.minutes)
    session.attendees << user

    Timecop.travel(Time.zone.parse("6:45"))

    expect {
      described_class.perform_now
    }.not_to change {
      Noticed::Notification.joins(:event).where(noticed_events: {record: session}, recipient: user).count
    }

    expect(session.sent_reminders).to eq([])
  end

  it "doesn't deliver the notification if the reminder window has already passed" do
    starts_at = Time.zone.parse("7:00")
    session = create(:session, conference: conference, location: location,
      starts_at: starts_at, ends_at: starts_at + 30.minutes)
    session.attendees << user

    Timecop.travel(Time.zone.parse("6:59"))

    expect {
      described_class.perform_now
    }.not_to change {
      Noticed::Notification.joins(:event).where(noticed_events: {record: session}, recipient: user).count
    }

    expect(session.sent_reminders).to eq([])
  end

  it "delivers the notification if the reminder window is active" do
    starts_at = Time.zone.parse("7:00")
    session = create(:session, conference: conference, location: location,
      starts_at: starts_at, ends_at: starts_at + 30.minutes)
    session.attendees << user

    Timecop.travel(Time.zone.parse("6:50"))

    expect {
      described_class.perform_now
    }.to change {
      Noticed::Notification.joins(:event).where(noticed_events: {record: session}, recipient: user).count
    }.by(1)

    session.reload
    expect(session.sent_reminders).to eq(["10 minutes"])
  end

  it "delivers the notification if the reminder window is active (grace period)" do
    starts_at = Time.zone.parse("7:00")
    session = create(:session, conference: conference, location: location,
      starts_at: starts_at, ends_at: starts_at + 30.minutes)
    session.attendees << user

    Timecop.travel(Time.zone.parse("6:51"))

    expect {
      described_class.perform_now
    }.to change {
      Noticed::Notification.joins(:event).where(noticed_events: {record: session}, recipient: user).count
    }.by(1)

    session.reload
    expect(session.sent_reminders).to eq(["10 minutes"])
  end

  it "prevents multiple deliveries of the same notification" do
    starts_at = Time.zone.parse("7:00")
    session = create(:session, conference: conference, location: location,
      starts_at: starts_at, ends_at: starts_at + 30.minutes)
    session.attendees << user

    Timecop.travel(Time.zone.parse("6:50"))

    expect {
      described_class.perform_now
    }.to change {
      Noticed::Notification.joins(:event).where(noticed_events: {record: session}, recipient: user).count
    }.by(1)

    expect {
      described_class.perform_now
    }.not_to change {
      Noticed::Notification.joins(:event).where(noticed_events: {record: session}, recipient: user).count
    }
  end
end
