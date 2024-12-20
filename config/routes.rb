Rails.application.routes.draw do
  # Home page and root route
  get 'home/index'
  root to: 'home#index'  # Ensure HomeController exists and has an index action

  resources :reviews, only: [:index, :show, :new, :create]
  
  # Devise for User authentication with custom registrations controller
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :users, only: [:show, :update]
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
  resources :chef_profiles, only: [:index, :show, :create, :update, :new, :edit] do
    resources :menu_items do # Allow all CRUD actions for menu items
      resources :ingredients, only: [:create, :update, :destroy]
      # Ensure the destroy action is available for menu items
      delete :destroy, on: :member
    end
    resources :reviews, only: [:index, :create, :update, :destroy]
    resources :chef_availabilities, only: [:index, :create, :destroy] # Add chef availabilities routes
  end

  # Bookings routes (not nested, accessible by both chefs and consumers)
  resources :bookings do
    collection do
      get ':step', to: 'bookings#wizard', as: 'wizard_step'  # Routes individual steps
    end
  end

  # Messages routes
  resources :messages, only: [:index, :create]

  # Optional routes for additional features
  resources :notifications, only: [:index] if defined?(NotificationsController)
  resources :favorites, only: [:create, :destroy] if defined?(FavoritesController) # Remove duplicate index route
end
