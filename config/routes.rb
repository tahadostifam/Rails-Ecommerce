Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  scope :api do
    post "users/login"
    post "users/register"
    post "users/authenticate"
  end
end
