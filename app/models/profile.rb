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
class Profile < ApplicationRecord
  has_one_attached :image

  belongs_to :profileable, polymorphic: true

  validates :uuid, uniqueness: true, presence: true

  before_validation :set_uuid

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end

  private

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
