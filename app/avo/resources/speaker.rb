class Avo::Resources::Speaker < Avo::BaseResource
  self.includes = [:profile]
  self.extra_params = [profile_attributes: [:name, :bio, :github_url, :linkedin_url, :twitter_url, :job_title, :is_public, :profileable_type, :profileable_id]]

  def fields
    field :id, as: :id
    field :profile, as: :has_one
    field :events, as: :has_many
    tool Avo::ResourceTools::NestedProfile, only_on: [:new, :edit]
  end
end
