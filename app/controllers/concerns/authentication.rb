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
      redirect_to new_session_path
    end
  end

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout
    Current.user = nil
    reset_session
  end
end
