Rails.application.routes.draw do
  
  root 'posts#index'

  resources :sessions
  resources :posts, only: [:new, :create, :index]
  resources :users, only: [:new, :create]
end
