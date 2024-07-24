class Avo::Resources::Profile < Avo::BaseResource
  # self.visible_on_sidebar = false
  self.title = :name

  self.search = {
    query: -> { query.ransack(name_cont: params[:q], m: "or").result(distinct: false) },
    item: -> do
      {
        title: "#{record.id} | #{record.name}"
      }
    end
  }

  def fields
    field :id, as: :id
    field :uuid, as: :text, readonly: true, only_on: [:show]
    field :name, as: :text
    field :profileable_type, as: :select, options: ["User", "Speaker"]
    field :profileable_id, as: :text
    field :bio, as: :text
    field :location, as: :text
    field :github_url, as: :text
    field :linkedin_url, as: :text
    field :twitter_url, as: :text
    field :is_public, as: :boolean
  end
end
