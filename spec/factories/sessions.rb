# == Schema Information
#
# Table name: sessions
#
#  id             :integer          not null, primary key
#  description    :string
#  ends_at        :datetime         not null
#  sent_reminders :json
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
#  index_sessions_on_location_id    (location_id)
#
FactoryBot.define do
  factory :session do
    title { "Keynote" }
    description { "The opening keynote" }
    starts_at { 1.day.from_now }
    ends_at { 1.day.from_now + 1.hour }

    trait :with_conference do
      conference
    end

    trait :with_location do
      location
    end
  end
end
