Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  get "/dashboard", to: "dashboard#show", as: "dashboard"

  resources :pools do
    resources :memberships, only: [:new, :create], controller: "pools/memberships"
  end

  get "up" => "rails/health#show", :as => :rails_health_check
  get '/check.txt', to: proc {[200, {}, ['it_works']]}
  authenticate :user, ->(user) { user.super_duper_admin? } do
    mount GoodJob::Engine => 'good_job'
  end
end
