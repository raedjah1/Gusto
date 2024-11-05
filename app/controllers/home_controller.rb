class HomeController < ApplicationController
  def index
    @featured_chefs = ChefProfile.limit(5) # Adjust limit as needed
  end
end