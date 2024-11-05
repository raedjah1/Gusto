class MenuItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_chef_profile
    before_action :set_menu_item, only: [:update, :destroy]
  
    def create
      @menu_item = @chef_profile.menu_items.build(menu_item_params)
      if @menu_item.save
        render json: @menu_item, status: :created
      else
        render json: { errors: @menu_item.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @menu_item.update(menu_item_params)
        render json: @menu_item, status: :ok
      else
        render json: { errors: @menu_item.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @menu_item.destroy
      head :no_content
    end
  
    private
  
    def set_chef_profile
      @chef_profile = ChefProfile.find(params[:chef_profile_id])
    end
  
    def set_menu_item
      @menu_item = @chef_profile.menu_items.find(params[:id])
    end
  
    def menu_item_params
      params.require(:menu_item).permit(:name, :description, :price)
    end
  end
  