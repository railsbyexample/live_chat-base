Rails.application.routes.draw do
  resources :contacts, only: %i[new create update destroy]
  resources :conversations
  resources :messages
  resources :users, only: :index

  root 'pages#index'

  devise_for :users

  mount ActionCable.server => '/cable'
end
