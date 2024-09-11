module Auth
  extend ActiveSupport::Concern

  included do
    def active_user
      User.find(session[:user_id])
    end

    def logout
      session.clear
    end

    def authenticated?
      active_user.present?
    end

    def admin_permission_required
      if !active_user.admin
        render json: { msg: "permission denied" }, status: :service_unavailable
      end
    end
  end
end
