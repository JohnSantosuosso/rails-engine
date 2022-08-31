Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/items/find_all', to: 'searches#find_matching_items'
      get '/merchants/find', to: 'searches#find_matching_merchant'
      get '/items/:id/merchant', to: 'item_merchants#index'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end

      resources :items, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
