class AdminConstraint
  def self.matches?(request)
    return unless request.session[:user_id]

    User.find_by(id: request.session[:user_id])&.admin?
  end
end
