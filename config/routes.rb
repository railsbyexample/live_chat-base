Rails.application.routes.draw do
  root 'pages#index'
  resources :contacts, except: :edit

  devise_for :users
  mount ActionCable.server => '/cable'
end
