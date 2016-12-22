Rails.application.routes.draw do
  resources :conversations
  resources :messages
  resources :users, only: [:index]

  root 'conversations#index'

  devise_for :users

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
