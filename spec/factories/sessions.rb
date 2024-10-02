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
FactoryBot.define do
  factory :session do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    starts_at { 1.day.from_now }
    ends_at { starts_at + 1.hour }

    after(:build) do |session|
      session.conference = Conference.first || create(:conference)
      session.location = session.conference.locations&.first || create(:location, conference: session.conference)
    end

    trait :past do
      starts_at { 1.day.ago }
    end

    trait :live do
      starts_at { 30.minutes.ago }
    end

    trait :starting_soon do
      starts_at { 1.hour.from_now }
    end

    trait :with_speakers do
      after(:create) do |session|
        create_list(:speaker, 2, sessions: [session])
      end
    end
  end
end
