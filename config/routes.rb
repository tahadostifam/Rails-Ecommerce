Rails.application.routes.draw do
  scope :users do
    post "/signup", to: "user#signup"
    post "/authentication", to: "user#authentication"
    post "/logout", to: "user#logout"
    post "/login_by_username", to: "user#login_by_username"
  end
end
