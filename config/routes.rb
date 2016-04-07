Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'check_out/:id' => 'home#check_out'
  resources :libraries
  resources :books
end
