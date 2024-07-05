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
class Profile < ApplicationRecord
  belongs_to :profileable, polymorphic: true

  has_one :self_ref, class_name: "Profile", foreign_key: :id, inverse_of: :self_ref, dependent: :destroy
  has_one :user, through: :self_ref, source: :profileable, source_type: "User"
  has_one :speaker, through: :self_ref, source: :profileable, source_type: "Speaker"
end
