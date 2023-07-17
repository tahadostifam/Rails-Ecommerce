Rails.application.routes.draw do
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
    post "/create", to: "product#create"
    put "/update", to: "product#update"
    delete "/delete", to: "product#delete"
  end

  scope :cart do
    post "/add_item", to: "cart#add_item"
    delete "/remove_item", to: "cart#remove_item"
  end
end
