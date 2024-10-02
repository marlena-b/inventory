# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'users#show'

  resources :products
  patch '/products/:id/transfer', to: 'stocks#transfer', as: 'transfer_product'
  resources :locations
  resources :categories
  resources :stocks, only: :update
  resources :stock_transfer_products, only: :destroy
  patch 'stock_transfer_products/update_bulk', to: 'stock_transfer_products#update_bulk',
                                               as: 'update_bulk_stock_transfer_products'
  resources :stock_transfers
  get '/stock_transfers/:id/products', to: 'stock_transfers#add_products_new', as: 'add_transfer_products_new'
  post '/stock_transfers/:id/products', to: 'stock_transfers#add_products', as: 'add_transfer_products'
end
