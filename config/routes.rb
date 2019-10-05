Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/most_revenue", to: "most_revenue#index"
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/:id/items", to: "items#index"
        get "/:id/invoices", to: "invoices#index"
      end
      namespace :items do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
      end
      namespace :invoices do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/:id/transactions", to: "transactions#index"
        get "/:id/invoice_items", to: "invoice_items#index"
        get "/:id/items", to: "items#index"
        get "/:id/customer", to: "customer#index"
      end
      namespace :invoice_items do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
      end
      namespace :customers do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
      end
      namespace :transactions do
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
