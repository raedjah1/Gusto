Rails.application.routes.draw do
  get "favorites/index"
  
  # Home page and root route
  get 'home/index'
  root to: 'home#index'  # Ensure HomeController exists and has an index action

  # Reviews
  resources :reviews, only: [:index, :show, :new, :create]

  # Devise for User authentication
  devise_for :users
  resources :users, only: [:show, :update]
  
  # Search and Favorites
  get 'search', to: 'search#show', as: 'search'
  get 'favorites', to: 'favorites#index', as: 'favorites'
  
  # Custom route for user dashboard
  get 'dashboard', to: 'users#dashboard', as: 'consumer_dashboard'

  # Health check route
  get 'up' => 'rails/health#show', as: :rails_health_check

  # PWA service worker and manifest routes
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Chef profiles and nested resources
  resources :chef_profiles, only: [:index, :show, :create, :update, :new] do
    resources :menu_items, only: [:create, :update, :destroy]
    resources :reviews, only: [:index, :create, :update, :destroy]
    
    # Nested Messages for Chef Profiles
    resources :messages, only: [:create]
  end

  # Bookings routes (not nested, accessible by both chefs and consumers)
  resources :bookings, only: [:index, :show, :create, :update, :destroy, :new]

  # Messages routes (not nested, general messages handling)
  resources :messages, only: [:index]

  # Optional routes for additional features
  resources :notifications, only: [:index] if defined?(NotificationsController)
  resources :favorites, only: [:index, :create, :destroy] if defined?(FavoritesController)
end
