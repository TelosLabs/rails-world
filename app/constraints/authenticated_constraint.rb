class AuthenticatedConstraint
  def self.matches?(request)
    request.session[:user_id].present?
  end
end
