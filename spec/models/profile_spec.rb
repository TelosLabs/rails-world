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
require "rails_helper"

RSpec.describe Profile, type: :model do
  let(:profile) { build_stubbed(:profile, :with_user) }

  it "has a valid factory" do
    expect(profile).to be_valid
  end

  describe "callbacks" do
    let(:profile) { build(:profile, :with_user) }

    it "sets a UUID before creation" do
      profile.save
      expect(profile.uuid).to be_present
    end
  end

  describe "validations" do
    it "validates socials urls" do
      %i[github_url linkedin_url twitter_url bluesky_url].each do |url|
        profile[url] = "http://foo bar.com"
        expect(profile).not_to be_valid

        profile[url] = "http://x.com"
        expect(profile).to be_valid
        expect(profile[url]).to eq("https://x.com")

        profile[url] = "x.com"
        expect(profile).to be_valid
        expect(profile[url]).to eq("https://x.com")

        profile[url] = "https://x.com"
        expect(profile).to be_valid
        expect(profile[url]).to eq("https://x.com")
      end
    end
  end
end
