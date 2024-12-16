class Bookings::WizardController < ApplicationController
  include Wicked::Wizard
  
  steps :select_chef, :select_date, :enter_details, :review
  
  def select_chef
    @booking = find_booking
    render_wizard
  end
  
  def select_date
    @booking = find_booking
    render_wizard
  end
  
  def confirm_booking
    @booking = find_booking
    render_wizard
  end
  
  def complete_booking
    @booking = find_booking
    render_wizard
  end
  
  def show
    @booking = find_booking
    session[:booking_id] = @booking.id if @booking.persisted?
    render_wizard
  end
  
  def update
    @booking = find_booking
    if @booking.update(booking_params)
      session[:booking_id] = @booking.id # Keep the booking object in the session
      render_wizard @booking
    else
      render_wizard @booking, status: :unprocessable_entity
    end
  end
  
  private
  
  def find_booking
    # Find an existing booking by the ID or create a new one if no ID is provided
    Booking.find_by(id: session[:booking_id]) || Booking.new
  end
  
  def booking_params
    params.require(:booking).permit(:chef_id, :date, :time, :guests, :special_requests)
  end
end