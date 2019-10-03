Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/most_revenue", to: "most_revenue#index"
        get "/find", to: "find#show"
      end
      namespace :items do
        get "/find", to: "find#show"
      end
      namespace :invoices do
        get "/find", to: "find#show"
      end
      resources :items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
