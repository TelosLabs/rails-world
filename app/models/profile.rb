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
class Profile < ApplicationRecord
  belongs_to :profileable, polymorphic: true

  has_one :self_ref, class_name: "Profile", foreign_key: :id, inverse_of: :self_ref, dependent: :destroy
  has_one :user, through: :self_ref, source: :profileable, source_type: "User"
  has_one :speaker, through: :self_ref, source: :profileable, source_type: "Speaker"

  validates :uuid, uniqueness: true

  before_create :set_uuid

  scope :public_profiles, -> { where(is_public: true) }

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
