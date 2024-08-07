# == Schema Information
#
# Table name: speakers
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Speaker < ApplicationRecord
  has_one :profile, as: :profileable, dependent: :destroy

  has_and_belongs_to_many :sessions

  [:name, :bio, :job_title, :github_url, :twitter_url, :linkedin_url, :image].each do |attr|
    delegate attr, "#{attr}=", to: :profile, allow_nil: true
  end

  accepts_nested_attributes_for :profile

  def profile
    super || build_profile
  end
end
