module Authorization
  extend ActiveSupport::Concern

  included do
    rescue_from ActionPolicy::Unauthorized, with: :redirect_after_unauthorized
  end

  private

  def redirect_after_unauthorized(exception)
    redirect_to root_path, alert: t("authorization.unauthorized")
  end
end
