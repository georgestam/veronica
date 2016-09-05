Rails.application.routes.draw do


  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '(:locale)', locale: /fr|es/ do

    root to: 'pages#home'

    get "users/:id", to: "profiles#show", as: :profile
    get "/dashboard", to: "profiles#dashboard", as: :dashboard
    get "profile/:id/edit", to: "profiles#edit", as: :edit_profile
    patch "/profile/:id", to: "profiles#update", as: :update_profile

    resources :cars do
      resources :journeys, only:[:new, :create, :edit, :update]
    end

    resources :journeys, only:[:index, :show, :destroy] do
      resources :passengers, only:[:create]
    end

    namespace :user do
      resources :journeys, only:[:index]
    end

    resources :passengers, only:[:update]

    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        get "journeys/driver", to: "journeys#driver", as: :journey_driver
        get "journeys/passenger", to: "journeys#passenger", as: :journey_passenger
        resources :journeys, only: [:index, :show, :update]
      end
    end
  end

  mount Attachinary::Engine => "/attachinary"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
