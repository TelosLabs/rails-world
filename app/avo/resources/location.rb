class Avo::Resources::Location < Avo::BaseResource
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
    field :name, as: :text
    field :conference, as: :belongs_to
    field :sessions, as: :has_many
  end
end
