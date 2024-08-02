class AdminConstraint
  def self.matches?(request)
    User.find_by(id: request.session[:user_id])&.admin?
  end
end
