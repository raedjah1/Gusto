class ChefProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_chef_profile, only: [:show, :edit, :update]

  def index
    @chef_profiles = ChefProfile.all
  
    # Filter by search term (case-insensitive)
    if params[:search].present?
      search_term = params[:search].downcase
      @chef_profiles = @chef_profiles.where("LOWER(specialty) LIKE ?", "%#{search_term}%")
    end
  
    # Filter by specialty
    if params[:specialty].present? && params[:specialty] != 'All Specialties'
      @chef_profiles = @chef_profiles.where(specialty: params[:specialty])
    end
  
    # Load and shuffle background images for chef profiles
    images_path = Rails.root.join('app', 'assets', 'images', 'chefs')
    @chef_images = Dir.entries(images_path).select { |f| f.match?(/\.(jpg|jpeg|png|gif)$/) }.shuffle
  end

  def show
    @reviews = @chef_profile.reviews
    # Update by allowing chef images(chef cards) to be clickable
    @chef_profile = ChefProfile.find(params[:id])
    @menu_items = @chef_profile.menu_items
  end

  def new
    @chef_profile = ChefProfile.new
  end

  def create
    @chef_profile = current_user.build_chef_profile(chef_profile_params)
    if @chef_profile.save
      redirect_to @chef_profile, notice: 'Your chef profile was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @chef_profile.update(chef_profile_params)
      redirect_to @chef_profile, notice: 'Your chef profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_chef_profile
    @chef_profile = ChefProfile.find(params[:id])
  end

  def chef_profile_params
    params.require(:chef_profile).permit(
      :bio, 
      :specialty, 
      :experience, 
      :availability, 
      :hourly_rate
    )
  end
end
