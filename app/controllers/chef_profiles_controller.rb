class ChefProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_chef, only: [ :edit, :update ]

  def edit
    @chef = current_user.chef_profile
  end

  private

  def require_chef
    unless current_user.chef?
      redirect_to root_path, alert: "You must be a chef to perform this action."
    end
  end
end
