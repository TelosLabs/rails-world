class UnauthenticatedConstraint
  def matches?(request)
    request.session[:user_id].nil?
  end
end