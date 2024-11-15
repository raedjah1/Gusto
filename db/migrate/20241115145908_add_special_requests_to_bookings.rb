class AddSpecialRequestsToBookings < ActiveRecord::Migration[7.2]
  def change
    add_column :bookings, :special_requests, :text
  end
end
