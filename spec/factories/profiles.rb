# == Schema Information
#
# Table name: profiles
#
#  id                   :integer          not null, primary key
#  bio                  :text
#  github_url           :string
#  in_app_notifications :boolean          default(TRUE), not null
#  is_public            :boolean          default(FALSE), not null
#  job_title            :string
#  linkedin_url         :string
#  mail_notifications   :boolean          default(TRUE), not null
#  name                 :string
#  profileable_type     :string           not null
#  twitter_url          :string
#  uuid                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  profileable_id       :integer          not null
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

    trait :with_user do
      association :profileable, factory: :user
    end
  end
end
