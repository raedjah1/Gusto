class ChefProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_chef_profile, only: [:show, :edit, :update]
  before_action :check_existing_profile, only: [:new, :create]
  before_action :authorize_user!, only: [:edit, :update]

  def index
    @chef_profiles = ChefProfile.all

    # Filter by search term (case-insensitive)
    if params[:search].present?
      search_term = params[:search].downcase.strip
      @chef_profiles = @chef_profiles.where('LOWER(specialty) LIKE ?', "%#{search_term}%")
    end

    # Filter by specialty
    if params[:specialty].present? && params[:specialty] != 'All Specialties'
      @chef_profiles = @chef_profiles.where(specialty: params[:specialty])
    end

    # Load and shuffle background images for chef profiles
    images_path = Rails.root.join('app', 'assets', 'images', 'chefs')
    if Dir.exist?(images_path)
      @chef_images = Dir.entries(images_path)
                        .select { |f| f.match?(/\.(jpg|jpeg|png|gif)$/) }
                        .shuffle
    else
      @chef_images = []
    end
  end

  def show
    @reviews = @chef_profile.reviews
    @menu_items = @chef_profile.menu_items.includes(:ingredients)
  rescue ActiveRecord::RecordNotFound
    redirect_to chef_profiles_path, alert: 'Chef profile not found.'
  end

  def new
    @chef_profile = ChefProfile.new
  end

  def create
    @chef_profile = current_user.build_chef_profile(chef_profile_params)
    
    if @chef_profile.save
      redirect_to @chef_profile, notice: 'Your chef profile was successfully created.'
    else
      flash.now[:alert] = 'Failed to create your chef profile. Please fix the errors below.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @chef_profile.update(chef_profile_params)
      redirect_to @chef_profile, notice: 'Your chef profile was successfully updated.'
    else
      flash.now[:alert] = 'Failed to update your chef profile. Please fix the errors below.'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_chef_profile
    @chef_profile = ChefProfile.find_by(id: params[:id])
    redirect_to chef_profiles_path, alert: 'Chef profile not found.' unless @chef_profile
  end

  def chef_profile_params
    params.require(:chef_profile).permit(
      :bio,
      :specialty,
      :experience,
      :availability,
      :hourly_rate,
      :profile_picture
    )
  end

  def check_existing_profile
    if current_user.chef_profile.present?
      redirect_to edit_chef_profile_path(current_user.chef_profile), 
                  alert: 'You already have a chef profile. You can edit it here.'
    end
  end

  def authorize_user!
    unless @chef_profile.user == current_user
      redirect_to chef_profiles_path, alert: 'You are not authorized to edit this profile.'
    end
  end
end
