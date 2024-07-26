class Avo::Resources::User < Avo::BaseResource
  self.includes = [:profile]
  self.index_query = -> { query.left_outer_joins(:profile).order("profiles.name") }
  self.extra_params = [profile_attributes: [:name, :bio, :github_url, :linkedin_url, :twitter_url, :job_title, :is_public, :profileable_type, :profileable_id]]

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
    field :profile, as: :has_one
    tool Avo::ResourceTools::NestedProfile, only_on: :new
    field :email, as: :text
    field :password, as: :password, only_on: :new
    field :password_confirmation, as: :password, only_on: :new
    field :role, as: :select, options: User.roles, include_blank: true, sortable: true, default: "user"
    field :mail_notifications_enabled, as: :boolean
    field :in_app_notifications_enabled, as: :boolean
  end
end
