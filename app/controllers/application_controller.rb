class ApplicationController < ActionController::Base
  include Authentication

  helper_method :internal_server_error
  skip_before_action :verify_authenticity_token

  rescue_from CanCan::AccessDenied do |exception|
    render json: { msg: "Access denied" }, status: :forbidden
  end

  protected

  def authenticate_user!
    unless user_signed_in?
      render json: { msg: "Login required" }, status: :forbidden
    end

    unless current_user.confirmed?
      render json: { msg: "Account did not confirmed" }, status: :forbidden
    end

    if current_user.locked?
      return render json: { msg: "Account locked" }, status: :forbidden
    end
  end

  private

  def internal_server_error
    render json: { msg: "Internal server error" }, status: :internal_server_error
  end
end
