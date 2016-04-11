Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'search', to: 'home#search', as: :search
  post 'transfer_to_library/:id', to: 'home#transfer_to_library'
  post 'transfer_to_usery/:id', to: 'home#transfer_to_user'

  post 'check_out/:id', to: 'home#check_out'
  post 'check_in/:id', to: 'home#check_in'

  resources :libraries
  resources :books
end
