class MenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chef_profile
  before_action :set_menu_item, only: [:edit, :update, :destroy]
  before_action :authorize_chef, only: [:new, :create, :edit, :update, :destroy]

  def index
    @menu_items = @chef_profile.menu_items.includes(:ingredients)
  end

  def new
    @menu_item = @chef_profile.menu_items.build
  end

  def create
    @menu_item = @chef_profile.menu_items.build(menu_item_params)
    
    if @menu_item.save
      redirect_to chef_profile_path(@chef_profile), notice: 'Menu item was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @menu_item.update(menu_item_params)
      redirect_to chef_profile_path(@chef_profile), notice: 'Menu item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @menu_item.destroy
    redirect_to chef_profile_path(@chef_profile), notice: 'Menu item was successfully deleted.'
  end

  private

  def set_chef_profile
    @chef_profile = ChefProfile.find(params[:chef_profile_id])
  end

  def set_menu_item
    @menu_item = @chef_profile.menu_items.find(params[:id])
  end

  def menu_item_params
    params.require(:menu_item).permit(:name, :description, :price, :image,
      ingredients_attributes: [:id, :name, :quantity, :unit, :_destroy])
  end

  def authorize_chef
    unless current_user == @chef_profile.user
      redirect_to chef_profile_path(@chef_profile), alert: 'You are not authorized to perform this action.'
    end
  end
end