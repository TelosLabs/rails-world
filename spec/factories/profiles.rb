# == Schema Information
#
# Table name: profiles
#
#  id                     :integer          not null, primary key
#  bio                    :text
#  github_url             :string
#  is_public              :boolean          default(FALSE), not null
#  job_title              :string
#  linkedin_url           :string
#  mail_notifications     :boolean          default(FALSE), not null
#  name                   :string
#  profileable_type       :string           not null
#  twitter_url            :string
#  uuid                   :string           not null
#  web_push_notifications :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  profileable_id         :integer          not null
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
    job_title { "Developer" }
    is_public { false }
    github_url { "https://github.com" }
    linkedin_url { "https://linkedin.com" }
    twitter_url { "https://twitter.com" }
    uuid { SecureRandom.uuid }

    trait :with_user do
      profileable { create(:user) }
    end

    trait :public do
      is_public { true }
    end

    trait :with_no_social_links do
      github_url { nil }
      twitter_url { nil }
      linkedin_url { nil }
    end
  end
end
