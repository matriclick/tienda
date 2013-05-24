class RemoveNoMoreBookingToService < ActiveRecord::Migration
  def up
  	remove_column :services, :no_more_bookings
  end

  def down
    add_column :services, :no_more_bookings, :boolean
  end
end
