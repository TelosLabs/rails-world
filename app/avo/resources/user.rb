class Avo::Resources::User < Avo::BaseResource
  self.includes = [:profile]
  self.index_query = -> { query.left_outer_joins(:profile).order("profiles.name") }

  self.search = {
    query: -> { query.ransack(email_cont: params[:q], m: "or").result(distinct: false) },
    item: -> do
      {
        title: "#{record.id} | #{record.email}"
      }
    end
  }

  def fields
    field :id, as: :id
    field :email, as: :text
    field :role, as: :select, options: User.roles, include_blank: true, sortable: true, default: "user"
    field :password, as: :password, only_on: :new
    field :password_confirmation, as: :password, only_on: :new
    field :profile, as: :has_one
  end
end
