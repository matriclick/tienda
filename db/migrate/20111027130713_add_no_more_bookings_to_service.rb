class AddNoMoreBookingsToService < ActiveRecord::Migration
  def change
    add_column :services, :no_more_bookings, :boolean, :default => false
  end
end
