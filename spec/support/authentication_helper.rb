module AuthenticationHelper
  def sign_in(user, password = "password2024")
    if respond_to?(:visit) # System specs
      visit new_user_session_path
      find_dti("email_field").set(user.email)
      find_dti("password_field").set(password)
      find_dti("sign_in_button").click
    else # Controller specs
      session[:user_id] = user.id
    end
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper, type: :system
  config.include AuthenticationHelper, type: :controller
end
