Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", :as => :rails_health_check

  root "home#index"

  get "/dashboard", to: "dashboard#show", as: "dashboard"
end
