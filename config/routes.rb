Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard', to: 'pages#dashboard'
    resources :users, only: [:index, :update, :destroy]
    resources :categories do
      resources :words
    end
  end
  devise_for :users,
  path: '',
  path_names: {sign_in: 'login', sign_up: 'registration', sign_out: 'logout'},
  controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}
  root 'pages#home'
  get 'categories', to: 'categories#index'
  resources :users , only: [:index, :show] do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
