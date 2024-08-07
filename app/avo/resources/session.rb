class Avo::Resources::Session < Avo::BaseResource
  self.index_query = -> { query.order(:title) }
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
    field :title, as: :text, sortable: true
    field :description, as: :textarea
    field :starts_at, as: :date_time,
      help: "The datetime field will use your browser's current timezone.", sortable: true,
      format: "FFFF"
    field :ends_at, as: :date_time,
      help: "The datetime field will use your browser's current timezone.", sortable: true,
      format: "FFFF"
    field :sent_reminders, only_on: :show
    field :location, as: :belongs_to
    field :conference, as: :belongs_to
    field :speakers, as: :has_and_belongs_to_many, can_create: false
    field :tags, as: :has_and_belongs_to_many
  end
end
