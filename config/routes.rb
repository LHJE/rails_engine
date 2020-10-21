Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      # namespace :customers do
      #   get '/find', to: 'search#show'
      #   get '/find_all', to: 'search#index'
      # end
      # resources :customers
      # namespace :invoice_items do
      #   get '/find', to: 'search#show'
      #   get '/find_all', to: 'search#index'
      # end
      # resources :invoice_items
      # namespace :invoices do
      #   get '/find', to: 'search#show'
      #   get '/find_all', to: 'search#index'
      # end
      # resources :invoices
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :items
      get "items/:id/merchant", to: 'items#merchant'
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'search#most_revenue'
      end
      resources :merchants
      get "merchants/:id/items", to: 'merchants#items'
      # namespace :transactions do
      #   get '/find', to: 'search#show'
      #   get '/find_all', to: 'search#index'
      # end
      # resources :transactions
    end
  end
end
