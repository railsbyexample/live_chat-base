Rails.application.routes.draw do
  resources :conversations
  resources :messages
  resources :users, only: :index

  resources :accounts, only: %i[new create]

  root 'accounts#new'

  devise_for :users, controllers: { invitations: 'auth/invitations' }

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
