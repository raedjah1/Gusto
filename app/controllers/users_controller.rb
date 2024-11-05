class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :update]
  
    # GET /users/:id
    def show
      render json: @user
    end
  
    # PATCH/PUT /users/:id
    def update
      if @user.update(user_params)
        render json: @user, status: :ok
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    # Set user by ID
    def set_user
      @user = User.find(params[:id])
    end
  
    # Strong parameters for user
    def user_params
      params.require(:user).permit(:name, :email)
    end
  end
  