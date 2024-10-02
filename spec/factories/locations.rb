# == Schema Information
#
# Table name: locations
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  conference_id :integer          not null
#
# Indexes
#
#  index_locations_on_conference_id           (conference_id)
#  index_locations_on_name_and_conference_id  (name,conference_id) UNIQUE
#
FactoryBot.define do
  factory :location do
    name { "Main Hall" }

    after(:build) do |location|
      location.conference ||= Conference.first || create(:conference)
    end
  end
end
