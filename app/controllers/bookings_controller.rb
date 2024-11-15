class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :update, :destroy]
  before_action :set_chef_profile, only: [:new, :create]

  def index
    bookings = current_user.role == 'chef' ? current_user.chef_profile.bookings : current_user.bookings
    render json: bookings
  end

  def show
    render json: @booking
  end

  def create
    @booking = current_user.bookings.build(booking_params)
    @booking.chef_profile = @chef_profile if @chef_profile # Associate chef profile if found
    if @booking.save
      render json: @booking, status: :created
    else
      render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @booking.update(booking_params)
      render json: @booking, status: :ok
    else
      render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    head :no_content
  end

  def new
    @booking = Booking.new(chef_profile: @chef_profile)
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_chef_profile
    @chef_profile = ChefProfile.find_by(id: params[:chef_profile_id]) if params[:chef_profile_id]
  end

  def booking_params
    params.require(:booking).permit(:chef_profile_id, :date, :time, :guests, :special_requests, :status)
  end
end
