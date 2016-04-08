Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  post 'check_out/:id' => 'home#check_out'
  post 'check_in/:id' => 'home#check_in'

  resources :libraries
  resources :books
end
