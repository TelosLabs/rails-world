class Avo::Resources::Tag < Avo::BaseResource
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
    field :name, as: :text
    field :events, as: :has_and_belongs_to_many
  end
end
