# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'users#show'

  resources :products
    get '/products/:id/transfer', to: 'stocks#edit_transfer', as: 'edit_transfer_product'
    patch '/products/:id/transfer', to: 'stocks#transfer', as: 'transfer_product'
  resources :locations
  resources :categories
  resources :stocks, only: :update
end
