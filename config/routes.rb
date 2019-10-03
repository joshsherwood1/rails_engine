Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/most_revenue", to: "most_revenue#index"
      end
      resources :items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index]
      resources :transactions, only: [:index]
    end
  end
end
