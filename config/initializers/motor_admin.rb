Rails.application.config.to_prepare do
  ALLOWED_RULES = ["admin", "seller"]

  Motor::ApplicationController.class_eval do
    before_action :authenticate_user!

    protected

    def current_user
      current_user_id = request.env['rack.session'][:current_user_id]
      @current_user ||= current_user_id && User.find_by(id: current_user_id)
    end

    def authenticate_user!
      if !current_user
        if !current_user.confirmed? || current_user.locked?
          return render json: { msg: "Login required" }, status: :forbidden
        end

        unless ALLOWED_RULES.include?(current_user.role)
          render json: { msg: "Access denied" }, status: :forbidden
        end
      end
    end
  end
end
