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

  def fields
    field :id, as: :id
    field :name, as: :text, sortable: true
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
