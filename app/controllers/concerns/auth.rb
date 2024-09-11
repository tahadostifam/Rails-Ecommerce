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
  end
end
