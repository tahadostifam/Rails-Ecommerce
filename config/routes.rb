Rails.application.routes.draw do
  scope :users do
    post "/login_by_username", to: "user#login_by_username"
  end
end
