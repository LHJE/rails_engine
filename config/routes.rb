Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :customers
      resources :merchants
      get "merchants/:id/items", to: 'merchants#items'
      resources :items
      get "items/:id/merchant", to: 'items#merchant'
      resources :invoices
      resources :invoice_items
      resources :transactions
    end
  end
end
