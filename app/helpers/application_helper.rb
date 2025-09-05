module ApplicationHelper
  include Pagy::Frontend

  def turbo_native_android_app?
    request.user_agent.include?("Turbo Native Android")
  end
end
