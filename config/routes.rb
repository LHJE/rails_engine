Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/find', to: 'search#show'
      end
      resources :customers
      namespace :invoice_items do
        get '/find', to: 'search#show'
      end
      resources :invoice_items
      resources :invoices
      resources :items
      get "items/:id/merchants", to: 'items#merchant'
      resources :merchants
      get "merchants/:id/items", to: 'merchants#items'
      resources :transactions
    end
  end
end
