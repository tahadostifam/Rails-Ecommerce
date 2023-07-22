class ApplicationController < ActionController::Base
  include Authentication

  helper_method :internal_server_error
  skip_before_action :verify_authenticity_token

  ##
  # The function checks if a user is signed in and returns a JSON response with an error message if not.
  def login_required
    unless user_signed_in?
      render json: { msg: "Login required" }, status: :forbidden
    end
  end

  private

  def internal_server_error
    render json: { msg: "Internal server error" }, status: :internal_server_error
  end
end
