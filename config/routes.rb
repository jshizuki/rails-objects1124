Rails.application.routes.draw do
  devise_for :objects_users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'objects_invoices#index'
  resources :objects_invoices
  resources :objects_products do
    member do
      post 'toggle_bookmark'
    end
  end
end
