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
    field :name, as: :text, sortable: true, link_to_record: true
    field :sessions, as: :has_and_belongs_to_many
  end
end
