class MenuItemsController < ApplicationController
    before_action :authenticate_user!, except: [:show] #Allow unauthenticated users to browse chef menus
    before_action :set_chef_profile, except: [:show]
    before_action :set_menu_item, only: [:show, :edit, :update, :destroy] #Add placeholder edit

    def show 
      # @menu_item 
    end

    def edit
      #Placeholder, for editing functionality
    end
  
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
      @menu_item = MenuItem.find(params[:id]) # Look up menu_item directly by its ID
    end
  
    def menu_item_params
      params.require(:menu_item).permit(:name, :description, :price)
    end
  end
  