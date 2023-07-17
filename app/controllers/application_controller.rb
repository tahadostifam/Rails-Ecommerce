class ApplicationController < ActionController::API
  include ValidateParams
  include Authentication

  def login_required
    unless user_signed_in?
      render json: { msg: "Login required" }, status: :forbidden
    end
  end

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
