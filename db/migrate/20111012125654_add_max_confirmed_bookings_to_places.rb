class AddMaxConfirmedBookingsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :max_confirmed_bookings, :integer
  end
end
