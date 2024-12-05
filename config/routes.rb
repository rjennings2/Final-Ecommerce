Rails.application.routes.draw do
  # Customer routes
  get "customers/new"
  post "customers/create"

  # Admin routes
  get "admins/dashboard"
  get "admin_sessions/new"
  post "admin_sessions/create"
  delete "admin_sessions/destroy"

  # Categories
  get "categories/show"
  resources :categories, only: [:show]

  # Root route
  root 'products#index'

  # Product routes
  resources :products, only: [:index, :show]

  # Admin login/logout
  get 'admin/login', to: 'admin_sessions#new', as: 'admin_login'
  post 'admin/login', to: 'admin_sessions#create'
  delete 'admin/logout', to: 'admin_sessions#destroy', as: 'admin_logout'

  # Admin dashboard
  get 'admin/dashboard', to: 'admins#dashboard', as: 'admin_dashboard'

  # Cart routes
  resources :cart, only: [:show] do
    post 'add', on: :collection, to: 'cart#add', as: 'add_to_cart'
    delete '/cart/remove/:product_id', to: 'cart#remove', as: 'remove_from_cart_cart_path'
    patch 'update', to: 'cart_items#update', as: 'update_cart'
    get 'checkout', on: :collection, to: 'cart#checkout'
    post 'place_order', on: :collection, to: 'cart#place_order'
  end

  get 'order_confirmed', to: 'orders#confirmed'

  # Admin resources (product management)
  namespace :admin do
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  # Customer authentication routes
  get 'signup', to: 'customers#new'
  post 'signup', to: 'customers#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Order routes
  resources :orders, only: [:show]

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes for service worker and manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end