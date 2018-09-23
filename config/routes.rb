Rails.application.routes.draw do
  root 'pages#index'
  resources :contacts, except: :edit

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  mount ActionCable.server => '/cable'
end
