class Avo::Resources::Profile < Avo::BaseResource
  self.visible_on_sidebar = false

  def fields
    field :id, as: :id
    field :uuid, as: :text, readonly: true
    field :name, as: :text
    field :bio, as: :text
    field :location, as: :text
    field :github_url, as: :text
    field :linkedin_url, as: :text
    field :twitter_url, as: :text
    field :is_public, as: :boolean
    field :profileable_type, as: :text
    field :profileable_id, as: :text
  end
end
