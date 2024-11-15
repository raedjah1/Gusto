class AddTimeToBookings < ActiveRecord::Migration[7.2]
  def change
    add_column :bookings, :time, :time
  end
end
