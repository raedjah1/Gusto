class ChefProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_chef_profile, only: [:show, :update]

  def index
    chef_profiles = ChefProfile.all
    render json: chef_profiles
  end

  def show
    render json: @chef_profile
  end

  def create
    @chef_profile = current_user.build_chef_profile(chef_profile_params)
    if @chef_profile.save
      render json: @chef_profile, status: :created
    else
      render json: { errors: @chef_profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @chef_profile.update(chef_profile_params)
      render json: @chef_profile, status: :ok
    else
      render json: { errors: @chef_profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_chef_profile
    @chef_profile = ChefProfile.find(params[:id])
  end

  def chef_profile_params
    params.require(:chef_profile).permit(:bio, :specialty, :experience, :availability)
  end
end
