# == Schema Information
#
# Table name: speakers
#
#  id         :integer          not null, primary key
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_speakers_on_slug  (slug) UNIQUE
#
class Speaker < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_one :profile, as: :profileable, dependent: :destroy

  has_and_belongs_to_many :sessions

  validates :slug, uniqueness: true

  [:name, :bio, :job_title, :github_url, :twitter_url, :linkedin_url, :uuid].each do |attr|
    delegate attr, "#{attr}=", to: :profile, allow_nil: true
  end

  accepts_nested_attributes_for :profile

  def profile
    super || build_profile
  end

  def image
    nil
  end
end
