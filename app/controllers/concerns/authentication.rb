module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :user_signed_in?

    before_action :authenticate_user, :authenticate_user!
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :authenticate_user!, **options
    end
  end

  private

  def current_user = Current.user

  def user_signed_in? = Current.user.present?

  def authenticate_user
    Current.user = User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    authenticate_user

    if !user_signed_in?
      flash[:notice] = I18n.t("authentication.unauthenticated")
      store_user_location
      redirect_to new_user_session_path
    end
  end

  def storable_location?
    request.get? &&
      !request.xhr? &&
      !turbo_frame_request? &&
      !excluded_path?
  end

  def excluded_path?
    [
      new_user_session_path,
      new_registration_path,
      user_session_path
    ].include?(request.path)
  end

  def store_user_location
    return unless storable_location?

    session[:original_request_path] = request.fullpath
  end

  def login(user)
    Current.user = user
    original_request_path = session[:original_request_path]
    reset_session
    session[:user_id] = user.id
    session[:original_request_path] = original_request_path
  end

  def logout
    Current.user = nil
    reset_session
  end
end
