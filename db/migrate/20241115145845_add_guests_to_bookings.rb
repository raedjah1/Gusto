class AddGuestsToBookings < ActiveRecord::Migration[7.2]
  def change
    add_column :bookings, :guests, :integer
  end
end
