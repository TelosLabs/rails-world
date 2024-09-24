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
  validates :github_url, url: {allow_blank: true, schemes: ["https"]}
  validates :linkedin_url, url: {allow_blank: true, schemes: ["https"]}
  validates :twitter_url, url: {allow_blank: true, schemes: ["https"]}

  before_validation :set_uuid
  before_validation :set_url_scheme

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end

  private

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def set_url_scheme
    %i[github_url linkedin_url twitter_url].each do |url|
      next if send(url).blank?

      uri_parse = URI.parse(send(url))

      if uri_parse.scheme.blank?
        self[url] = "https://#{send(url)}"
      elsif uri_parse.scheme == "http"
        self[url] = send(url).gsub("http://", "https://")
      end
    rescue URI::InvalidURIError
      next
    end
  end
end
