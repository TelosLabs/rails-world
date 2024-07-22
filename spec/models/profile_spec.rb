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
    context "with a valid UUID" do
      it "is valid" do
        profile.uuid = SecureRandom.uuid
        expect(profile).to be_valid
      end
    end

    context "with an invalid UUID" do
      it "is invalid" do
        profile.uuid = "invalid"
        expect(profile).not_to be_valid
      end
    end
  end
end
