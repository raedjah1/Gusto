class MenuItemsController < ApplicationController
  before_action :authenticate_user!               # Ensures user is logged in
  before_action :set_chef_profile                 # Sets the chef profile for each action
  before_action :set_menu_item, only: [:edit, :update, :destroy]  # Finds the menu item for editing, updating, or destroying
  before_action :authorize_chef, only: [:new, :create, :edit, :update, :destroy]  # Ensures only the chef can manage their menu items

  # Display all menu items for a specific chef profile
  def index
    @menu_items = @chef_profile.menu_items.includes(:ingredients)  # Eager load ingredients to avoid N+1 queries
  end

  # Display the form for creating a new menu item
  def new
    @menu_item = @chef_profile.menu_items.build
  end

  # Create a new menu item for the chef profile
  def create
    @menu_item = @chef_profile.menu_items.build(menu_item_params)  # Build the menu item using the params

    if @menu_item.save
      redirect_to chef_profile_path(@chef_profile), notice: 'Menu item was successfully created.'  # Redirect on success
    else
      render :new  # Re-render the form if the save failed
    end
  end

  # Edit an existing menu item
  def edit
  end

  # Update an existing menu item
  def update
    if @menu_item.update(menu_item_params)
      redirect_to chef_profile_path(@chef_profile), notice: 'Menu item was successfully updated.'  # Redirect on success
    else
      render :edit  # Re-render the form if the update failed
    end
  end

  # Destroy an existing menu item
  def destroy
    @menu_item.destroy
    redirect_to chef_profile_path(@chef_profile), notice: 'Menu item was successfully deleted.'  # Redirect after deletion
  end

  private

  # Sets the chef profile based on the chef_profile_id parameter
  def set_chef_profile
    @chef_profile = ChefProfile.find(params[:chef_profile_id])
  end

  # Finds the menu item by ID within the chef profile
  def set_menu_item
    @menu_item = @chef_profile.menu_items.find(params[:id])
  end

  # Strong parameters for the menu item, including nested ingredients
  def menu_item_params
    params.require(:menu_item).permit(:name, :description, :price, :image,
      ingredients_attributes: [:id, :name, :quantity, :unit, :_destroy])
  end

  # Ensures that the current user is the chef associated with the profile
  def authorize_chef
    unless current_user == @chef_profile.user
      redirect_to chef_profile_path(@chef_profile), alert: 'You are not authorized to perform this action.'  # Redirect if not authorized
    end
  end
end
