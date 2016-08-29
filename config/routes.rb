Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "users/:id", to: "profiles#show", as: :profile
  get "users/edit", to: "profiles#edit", as: :edit_profile
  patch "/profile", to: "profiles#update", as: :update_profile

  resources :journey, only:[:index, :show, :edit, :update, :destroy] do
    resources :passenger, only:[:create]
  end

  resources :cars do
    resources :journeys, only:[:new, :create]
  end

  resources :passengers, only:[:update]

end
