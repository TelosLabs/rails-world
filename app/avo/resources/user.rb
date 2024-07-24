class Avo::Resources::User < Avo::BaseResource
  self.includes = [:profile]
  self.search = {
    query: -> { query.ransack(email_cont: params[:q], m: "or").result(distinct: false) },
    item: -> do
      {
        title: "[#{record.id}] #{record.email}"
      }
    end
  }

  def fields
    field :id, as: :id
    field :profile, as: :has_one
    field :email, as: :text
    field :role, as: :select, options: User.roles, include_blank: true
    field :mail_notifications_enabled, as: :boolean
    field :in_app_notifications_enabled, as: :boolean
  end
end
