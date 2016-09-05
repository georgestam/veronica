Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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
      resources :journeys, only: [ :show]
    end
  end

  mount Attachinary::Engine => "/attachinary"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
