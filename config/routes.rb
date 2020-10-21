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
      namespace :invoices do
        get '/find', to: 'search#show'
      end
      resources :invoices
      namespace :items do
        get '/find', to: 'search#show'
      end
      resources :items
      get "items/:id/merchants", to: 'items#merchant'
      namespace :merchants do
        get '/find', to: 'search#show'
      end
      resources :merchants
      get "merchants/:id/items", to: 'merchants#items'
      namespace :transactions do
        get '/find', to: 'search#show'
      end
      resources :transactions
    end
  end
end
