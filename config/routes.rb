Rails.application.routes.draw do
  root "home#index"

  devise_for :users, controllers: {passwords: :passwords}

  get "/dashboard", to: "dashboard#show", as: "dashboard"

  resources :pools do
    resources :memberships, only: [:new, :create], controller: "pools/memberships"
    resources :questions, only: [:create, :destroy, :edit, :update], controller: "pools/questions"
    resources :entries, only: [:show, :create, :update, :destroy], controller: "pools/entries" do
      member do
        post "/paid", to: "pools/entries#paid", as: "paid"
        post "/unpaid", to: "pools/entries#unpaid", as: "unpaid"
      end
    end
    member do
      get "/invite/:token", to: "pools#invite", as: "invite"
    end
  end

  put "/memberships/:id/accept", to: "pools/memberships#accept", as: "accept_membership"
  patch "/memberships/:id/accept", to: "pools/memberships#accept"
  delete "/memberships/:id", to: "pools/memberships#destroy", as: "membership"

  get "up" => "rails/health#show", :as => :rails_health_check
  authenticate :user, ->(user) { user.super_duper_admin? } do
    mount GoodJob::Engine => "good_job"
  end
end
