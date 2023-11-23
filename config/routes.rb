Rails.application.routes.draw do
  get 'public_pages/home'
  authenticated :user do
    root 'groups#index', as: :authenticated_root
  end
  
  unauthenticated do
    root 'public_pages#home', as: :unauthenticated_root
  end
  
  devise_for :users
  resources :groups do
    resources :payments, only: [:index, :new, :create, :destroy]
  end

  resources :payments, only: [:index, :show, :new, :create, :destroy]
  resources :users

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "groups#index"
end
