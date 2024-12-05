Rails.application.routes.draw do
  get "customers/new"
  get "customers/create"
  get "admins/dashboard"
  get "admin_sessions/new"
  get "admin_sessions/create"
  get "admin_sessions/destroy"
  get "categories/show"
  root 'products#index'
  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  get 'admin/login', to: 'admin_sessions#new', as: 'admin_login'
  post 'admin/login', to: 'admin_sessions#create'
  delete 'admin/logout', to: 'admin_sessions#destroy', as: 'admin_logout'

  get 'admin/dashboard', to: 'admins#dashboard', as: 'admin_dashboard'

  get 'cart/show', to: 'cart#show', as: 'cart'
  post 'cart/add', to: 'cart#add', as: 'add_cart'
  delete 'cart/remove/:product_id', to: 'cart#remove', as: 'remove_cart'
  patch 'cart/update/:product_id', to: 'cart#update', as: 'update_cart'

  namespace :admin do
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  get 'signup', to: 'customers#new'
  post 'signup', to: 'customers#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :orders, only: [:show]
  resources :cart, only: [:show] do
    get 'checkout', on: :collection
    post 'place_order', on: :collection
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end