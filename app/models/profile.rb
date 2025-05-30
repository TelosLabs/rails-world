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
