Rails.application.routes.draw do
  resources :contacts
  resources :conversations
  resources :messages
  resources :users, only: :index

  root 'pages#index'

  devise_for :users

  mount ActionCable.server => '/cable'
end
