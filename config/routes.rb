Rails.application.routes.draw do
  resources :conversations
  resources :messages
  resources :users, only: :index

  resources :accounts, only: %i[new create]

  root 'pages#index'

  devise_for :users, controllers: { invitations: 'auth/invitations' }

  mount ActionCable.server => '/cable'
end
