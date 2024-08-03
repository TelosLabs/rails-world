class Avo::Resources::Conference < Avo::BaseResource
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
    field :locations, as: :has_many
    field :sessions, as: :has_many
  end
end
