module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_user
    helper_method :current_user
    helper_method :user_signed_in?
  end

  ##
  # The `login_user` function sets the `current_user_id` session variable to the provided `user_id`.
  #
  # Args:
  #   user_id: The user_id parameter is the unique identifier for the user who is logging in. It is used to set the
  # current_user_id in the session, which allows the application to keep track of the currently logged in user.
  def login_user(user_id)
    session[:current_user_id] = user_id
  end

  ##
  # The function `logout_user` resets the session for the current user.
  def logout_user
    reset_session
  end

  private

  def current_user
    @current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  def user_signed_in?
    @current_user.present?
  end
end
