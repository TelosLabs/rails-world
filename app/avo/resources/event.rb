class Avo::Resources::Event < Avo::BaseResource
  self.search = {
    query: -> { query.ransack(title_cont: params[:q], m: "or").result(distinct: false) },
    item: -> do
      {
        title: "[#{record.id}] #{record.title}"
      }
    end
  }

  def fields
    field :id, as: :id
    field :title, as: :text
    field :description, as: :textarea
    field :starts_at, as: :date_time
    field :ends_at, as: :date_time
    field :location, as: :belongs_to
    field :conference, as: :belongs_to
    field :speakers, as: :has_and_belongs_to_many
    field :users, as: :has_and_belongs_to_many
    field :tags, as: :has_and_belongs_to_many
  end
end
