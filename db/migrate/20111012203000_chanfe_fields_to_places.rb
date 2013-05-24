class ChanfeFieldsToPlaces < ActiveRecord::Migration
  def change
    change_column :places, :max_bookings, :integer, :default => 3
    change_column :places, :max_confirmed_bookings, :integer, :default => 2
  end
end
