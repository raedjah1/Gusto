class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = current_user.bookings
  end

  def show
  end

  def new
    @booking = Booking.new
    # Redirect to the wizard starting at the 'select_chef' step
    redirect_to wizard_step_bookings_path(step: :select_chef)
  end

  def edit
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: 'Booking was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_url, notice: 'Booking was successfully canceled.'
  end

  # Wizard step controller
  def wizard
    @step = params[:step]
    @booking = current_user.bookings.new # Initialize or retrieve the booking
    render 'wizard'
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:chef_profile_id, :date, :time, :guests, :special_requests, :user_id, :status)
  end
end
