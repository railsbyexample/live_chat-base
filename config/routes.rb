Rails.application.routes.draw do
  resources :messages
  resources :chat_rooms
  resources :users, only: [:index]
  root 'chat_rooms#index'

  devise_for :users

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
