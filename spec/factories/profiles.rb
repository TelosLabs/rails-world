# == Schema Information
#
# Table name: profiles
#
#  id               :integer          not null, primary key
#  bio              :string
#  github_url       :string
#  is_public        :boolean          default(FALSE), not null
#  linkedin_url     :string
#  location         :string
#  name             :string
#  profileable_type :string           not null
#  twitter_url      :string
#  uuid             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  profileable_id   :integer          not null
#
# Indexes
#
#  index_profiles_on_profileable  (profileable_type,profileable_id)
#  index_profiles_on_uuid         (uuid) UNIQUE
#
FactoryBot.define do
  factory :profile do
    name { "John Doe" }
    bio { "About me" }
    location { "New York" }
    is_public { false }
    github_url { "https://github.com" }
    linkedin_url { "https://linkedin.com" }
    twitter_url { "https://twitter.com" }
    uuid { SecureRandom.uuid }

    trait :with_user do
      association :profileable, factory: :user
    end

    trait :public do
      is_public { true }
    end
  end
end
