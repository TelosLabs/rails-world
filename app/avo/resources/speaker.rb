class Avo::Resources::Speaker < Avo::BaseResource
  self.includes = [:profile]
  self.search = {
    query: -> { query.ransack(name_cont: params[:q], m: "or").result(distinct: false) },
    item: -> do
      {
        title: "#{record.id} | #{record.email}"
      }
    end
  }
  self.find_record_method = -> {
    if id.is_a?(Array)
      query.where(slug: id)
    else
      query.friendly.find id
    end
  }

  def fields
    field :id, as: :id
    field :name, as: :text, sortable: -> { query.order("profiles.name #{direction}") }, link_to_record: true
    field :slug, as: :text, hide_on: :new
    field :image, as: :file, accept: "image/*", only_on: [:show, :forms]
    field :image_presence, name: "Image", as: :boolean, only_on: :index do
      record.image.attached?
    end
    field :bio, as: :textarea
    field :job_title, as: :text
    field :github_url, as: :text
    field :linkedin_url, as: :text
    field :twitter_url, as: :text
    field :sessions, as: :has_many
  end
end
