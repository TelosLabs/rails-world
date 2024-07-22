class Avo::Resources::Profile < Avo::BaseResource
  self.search = {
    query: -> { query.ransack(name_cont: params[:q], m: "or").result(distinct: false) },
    item: -> do
      {
        title: "[#{record.id}] #{record.name}"
      }
    end
  }
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
