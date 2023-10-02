Rails.application.routes.draw do
  devise_for :objects_users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'objects_invoices#index'

  resources :objects_invoices do
    collection do
      post 'remove_products/:objects_product_id', action: :remove_product_from_invoice, as: 'remove_products'
    end
    member do
      post 'remove_products/:objects_product_id', action: :remove_product_from_invoice, as: 'remove_products'
    end
  end

  resources :objects_products do
    member do
      post 'toggle_bookmark'
    end
  end

  resources :objects_collections
end
