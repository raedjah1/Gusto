class ChefProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_chef_profile, only: [:show, :edit, :update]

  def index
    @chef_profiles = ChefProfile.all
    
    if params[:search].present?
      @chef_profiles = @chef_profiles.where("specialty ILIKE ?", "%#{params[:search]}%")
    end

    if params[:specialty].present? && params[:specialty] != 'All Specialties'
      @chef_profiles = @chef_profiles.where(specialty: params[:specialty])
    end
  end

  def show
    @reviews = @chef_profile.reviews
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
