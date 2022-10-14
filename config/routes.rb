Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :workshops, only: %i[index show]
  resources :bookings, only: %i[create]
end
