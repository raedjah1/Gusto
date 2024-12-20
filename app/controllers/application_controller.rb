class ApplicationController < ActionController::Base
  include SpeechHelper
  include SpeechRecognitionHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Custom error handling for smoother user experience
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found

  protected

  # Configures extra permitted parameters for Devise, specifically allowing the `name` and `role` fields.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role]) # Allow both `name` and `role`
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role]) # Allow both `name` and `role`
  end

  # Redirect user after sign-in based on role
  def after_sign_in_path_for(resource)
    if resource.role == 'chef'
      chef_dashboard_path # or any specific path for chefs
    else
      consumer_dashboard_path # or any specific path for consumers
    end
  end

  private

  # Friendly error redirection for not found errors
  def not_found
    redirect_to root_path, alert: 'Page not found.'
  end
end
