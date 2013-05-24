class PolymorphicNoMoreBookings < ActiveRecord::Migration
  def change
		change_table :no_more_bookings do |t|
			t.rename :service_id, :no_more_bookable_id
			t.string :no_more_bookable_type
		end
  end
end
