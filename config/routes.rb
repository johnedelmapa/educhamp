Rails.application.routes.draw do
  devise_for :users,
  path: '',
  path_names: {sign_in: 'login', sign_up: 'registration', sign_out: 'logout'},
  controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}
  root 'pages#home'
  resources :users , only: [:index, :show] do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
