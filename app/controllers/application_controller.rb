class ApplicationController < ActionController::API
  include ValidateParams
  include Authentication

  ##
  # The function checks if a user is signed in and returns a JSON response with an error message if not.
  def login_required
    unless user_signed_in?
      render json: { msg: "Login required" }, status: :forbidden
    end
  end

  ##
  # The `limit_access` function checks if the current user has access to a specific action based on their role and renders
  # an error message if they don't.
  #
  # Args:
  #   action_name: The `action_name` parameter represents the name of the action that you want to limit access to. It
  # could be a string or symbol representing the action name.
  #   role_required: The `role_required` parameter is the role that is required to access a specific action. It is used to
  # check if the current user has the necessary role to perform the action.
  def limit_access(action_name, role_required)
    user_role = current_user.access[:role]

    unless user_role
      user_role = :user
    end

    role = Access.new(current_user.access[:list], user_role, controller_name)

    unless role.has_access? action_name, role_required
      render json: { msg: "No access to this action", detail: { role: user_role, access: current_user.access[:list], action_name: action_name } }, status: :forbidden
    end
  end
end
