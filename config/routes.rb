Rails.application.routes.draw do
  mount Motor::Admin => '/admin_panel'

  scope :api, defaults: { format: :json } do
    scope :v1 do
      scope :users do
        post "/signup", to: "user#signup"
        post "/authentication", to: "user#authentication"
        post "/logout", to: "user#logout"
        post "/login_by_username", to: "user#login"
        post "/login_by_phone", to: "phone_otp#login_by_phone"
        post "/verify_otp_code", to: "phone_otp#verify_otp_code"
      end

      scope :products do
        get "/index", to: "product#index"
      end

      scope :cart do
        get "/index", to: "cart#index"
        post "/add_item", to: "cart#add_item"
        delete "/remove_item", to: "cart#remove_item"
        put "/update_item", to: "cart#update_item"
      end
    end
  end
end
