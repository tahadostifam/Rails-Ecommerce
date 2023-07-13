Rails.application.routes.draw do
  scope :auth do
    get "/login", to: "users#login"
  end
end
