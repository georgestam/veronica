Rails.application.routes.draw do


  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '(:locale)', locale: /fr|es/ do

    root to: 'pages#home'

    get "users/:id", to: "profiles#show", as: :profile
    get "/dashboard", to: "profiles#dashboard", as: :dashboard
    get "profile/:id/edit", to: "profiles#edit", as: :edit_profile
    patch "/profile/:id", to: "profiles#update", as: :update_profile

    get "/profile/:id/", to: "profiles#teacher", as: :teacher_profile

    resources :cars, only:[:index, :new, :create, :edit, :update,:destroy] do
      resources :journeys, only:[:new, :create]
      resources :availabilities, only:[:new, :create, :destroy]
    end

    resources :journeys, only:[:index, :show, :destroy, :update, :edit] do
      resources :passengers, only:[:create, :destroy]
    end

    # namespace :user do
      # resources :journeys, only:[:index]
    # end
  end

  mount Attachinary::Engine => "/attachinary"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
