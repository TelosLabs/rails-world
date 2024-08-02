require "rails_helper"

RSpec.describe SessionReminderJob, type: :job do
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
    session_starting_times = ["7:00", "8:18", "9:50", "10:01", "12:59", "14:15", "15:33", "16:00", "17:30", "18:11"]

    sessions = session_starting_times.map do |time|
      starts_at = Time.zone.parse(time)
      session = create(:session, conference: conference, location: location, starts_at: starts_at, ends_at: starts_at + 30.minutes)
      session.users << user
      session
    end

    sessions.each do |session|
      Session::REMINDER_TIME_BEFORE_EVENT.each do |time_before_session|
        Timecop.travel(session.starts_at - time_before_session)

        expect {
          described_class.perform_now
        }.to change {
          Noticed::Notification.joins(:event).where(noticed_events: {record: session}, recipient: user).count
        }.by(1)

        nots = Noticed::Notification.joins(:event).where(noticed_events: {record: session}, recipient: user)
        expect(nots.last.params[:time_before_session]).to eq(time_before_session.inspect)
      end
    end
  end

  it "prevents multiple deliveries of the same notification" do
    session = create(:session, conference: conference, location: location, starts_at: now + 1.hour, ends_at: now + 1.hour + 30.minutes)
    session.users << user

    Session::REMINDER_TIME_BEFORE_EVENT.each do |time_before_session|
      Timecop.travel(session.starts_at - time_before_session)

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
end
