Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/most_revenue", to: "most_revenue#index"
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/:id/items", to: "items#index"
        get "/:id/invoices", to: "invoices#index"
        get "/random", to: "random#show"
        get "/revenue", to: "revenue#index"
        get "/:id/favorite_customer", to: "favorite_customer#show"
      end
      namespace :items do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/random", to: "random#show"
        get "/most_revenue", to: "most_revenue#index"
        get ":id/best_day", to: "best_day#show"
      end
      namespace :invoices do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/:id/transactions", to: "transactions#index"
        get "/:id/invoice_items", to: "invoice_items#index"
        get "/:id/items", to: "items#index"
        get "/:id/customer", to: "customer#show"
        get "/:id/merchant", to: "merchant#show"
        get "/random", to: "random#show"
      end
      namespace :invoice_items do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/:id/item", to: "item#show"
        get "/:id/invoice", to: "invoice#show"
        get "/random", to: "random#show"
      end
      namespace :customers do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/:id/invoices", to: "invoices#index"
        get "/:id/transactions", to: "transactions#index"
        get "/random", to: "random#show"
      end
      namespace :transactions do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/:id/invoice", to: "invoice#show"
        get "/random", to: "random#show"
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
