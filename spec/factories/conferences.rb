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
      after(:create) do |conference|
        create(:location, conference: conference)
      end
    end
  end
end
