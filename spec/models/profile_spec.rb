# == Schema Information
#
# Table name: profiles
#
#  id               :integer          not null, primary key
#  bio              :string
#  github_url       :string
#  is_public        :boolean
#  linkedin_url     :string
#  location         :string
#  name             :string
#  profileable_type :string           not null
#  twitter_url      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  profileable_id   :integer          not null
#
# Indexes
#
#  index_profiles_on_profileable  (profileable_type,profileable_id)
#
require "rails_helper"

RSpec.describe Profile, type: :model do
  let(:profile) { build_stubbed(:profile, :with_user) }

  it "has a valid factory" do
    expect(profile).to be_valid
  end
end
