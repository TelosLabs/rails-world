module NavigationHelper
  # Todo: A better approach would be to support authenticated root and unauthenticated root in routes.rb
  def homepage_link
    user_signed_in? ? root_path : new_session_path
  end
end
