# == Schema Information
#
# Table name: conferences
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :conference do
    name { "RailsWorld 2024" }

    trait :with_location do
      location
    end
  end
end
