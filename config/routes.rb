Rails.application.routes.draw do
  devise_for :users,
  path: '',
  path_names: {sign_in: 'login', sign_up: 'registration', sign_out: 'logout'},
  controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
