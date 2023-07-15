module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_user
    helper_method :current_user
    helper_method :user_signed_in?
  end

  def login_user(user_id)
    session[:current_user_id] = user_id
  end

  def logout_user
    reset_session
  end

  private

  def current_user
    CurrentUser.user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  def user_signed_in?
    CurrentUser.user.present?
  end
end
