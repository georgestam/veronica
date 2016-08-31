Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'confirmations' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "users/:id", to: "profiles#show", as: :profile
  get "profile/edit", to: "profiles#edit", as: :edit_profile
  patch "/profile", to: "profiles#update", as: :update_profile

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

  mount Attachinary::Engine => "/attachinary"
end
