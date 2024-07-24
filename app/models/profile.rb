# == Schema Information
#
# Table name: profiles
#
#  id                   :integer          not null, primary key
#  bio                  :text
#  github_url           :string
#  in_app_notifications :boolean          default(TRUE), not null
#  is_public            :boolean          default(FALSE), not null
#  linkedin_url         :string
#  location             :string
#  mail_notifications   :boolean          default(TRUE), not null
#  name                 :string
#  profileable_type     :string           not null
#  twitter_url          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  profileable_id       :integer          not null
#
# Indexes
#
#  index_profiles_on_profileable  (profileable_type,profileable_id)
#
class Profile < ApplicationRecord
  has_one_attached :image

  has_one :self_ref, class_name: "Profile", foreign_key: :id, inverse_of: :self_ref
  has_one :user, through: :self_ref, source: :profileable, source_type: "User"
  has_one :speaker, through: :self_ref, source: :profileable, source_type: "Speaker"

  belongs_to :profileable, polymorphic: true
end
