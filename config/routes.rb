Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index]
      resources :merchants, only: [:index]
      resources :customers, only: [:index]
      resources :invoices, only: [:index]
      resources :invoice_items, only: [:index]
      resources :transactions, only: [:index]
      get "/merchants/:merchant_id/items", to: "items#index"
      get "/merchants/most_revenue", to: "merchants#most_revenue_for_merchants"
    end
  end
end
