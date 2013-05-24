class AddMaxBookingsToPlace < ActiveRecord::Migration
  def change
    add_column :places, :max_bookings, :integer, :default => 10
  end
end
