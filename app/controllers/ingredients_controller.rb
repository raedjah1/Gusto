class IngredientsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_menu_item
    before_action :set_ingredient, only: [:update, :destroy]
  
    # Create a new ingredient for a menu item
    def create
      @ingredient = @menu_item.ingredients.build(ingredient_params)
      if @ingredient.save
        render json: @ingredient, status: :created
      else
        render json: { errors: @ingredient.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # Update an existing ingredient
    def update
      if @ingredient.update(ingredient_params)
        render json: @ingredient, status: :ok
      else
        render json: { errors: @ingredient.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # Delete an ingredient
    def destroy
      @ingredient.destroy
      head :no_content
    end
  
    private
  
    # Find the parent menu item
    def set_menu_item
      @menu_item = MenuItem.find(params[:menu_item_id])
    end
  
    # Find the ingredient to update or delete
    def set_ingredient
      @ingredient = @menu_item.ingredients.find(params[:id])
    end
  
    # Permit strong parameters
    def ingredient_params
      params.require(:ingredient).permit(:name, :quantity)
    end
  end
  