class Avo::Resources::Speaker < Avo::BaseResource
  self.visible_on_sidebar = false
  self.includes = [:profile]

  def fields
    field :id, as: :id
    field :profile, as: :has_one
    field :events, as: :has_many
    tool Avo::ResourceTools::NestedProfile, only_on: [:new, :edit]
  end
end
