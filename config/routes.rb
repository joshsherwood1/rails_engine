Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index]
      resources :merchants, only: [:index]
      resources :customers, only: [:index]
      resources :invoices, only: [:index]
    end
  end
end
