class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :dashboard]

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

  # GET /dashboard
  def dashboard
    @user = current_user
    # This will render the dashboard view, using @user for the current user
    # Add any additional data here if needed, like recent activity or notifications
  end

  private

  # Set user by ID or default to the current user
  def set_user
    @user = params[:id] ? User.find_by(id: params[:id]) : current_user
    unless @user
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  # Strong parameters for user
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
