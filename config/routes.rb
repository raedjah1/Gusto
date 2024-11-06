Rails.application.routes.draw do
  # Home page and root route
  get 'home/index'
  root to: 'home#index'  # Ensure HomeController exists and has an index action

  # Devise for User authentication
  devise_for :users

  # Health check route
  get 'up' => 'rails/health#show', as: :rails_health_check

  # PWA service worker and manifest routes
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # User routes
  resources :users, only: [:show, :update]

  # Chef profiles and nested resources
  resources :chef_profiles, only: [:index, :show, :create, :update] do
    resources :menu_items, only: [:create, :update, :destroy]
    resources :reviews, only: [:index, :create]
  end

  # Bookings routes (not nested, accessible by both chefs and consumers)
  resources :bookings, only: [:index, :show, :create, :update, :destroy]

  # Messages routes
  resources :messages, only: [:index, :create]

  # Optional routes for additional features
  resources :notifications, only: [:index] if defined?(NotificationsController)
  resources :favorites, only: [:index, :create, :destroy] if defined?(FavoritesController)
end
