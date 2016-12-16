Rails.application.routes.draw do
  resources :conversations
  resources :messages
  resources :chat_rooms
  resources :users, only: [:index]

  root 'chat_rooms#index'

  get 'my_chats', to: 'conversations#chats'
  get 'my_friends', to: 'users#friends'
  get 'my_profile', to: 'users#profile'

  devise_for :users

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
