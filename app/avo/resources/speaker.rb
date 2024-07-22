class Avo::Resources::Speaker < Avo::BaseResource
  def fields
    field :id, as: :id
    field :profile, as: :has_one
    field :events, as: :has_many
  end
end
