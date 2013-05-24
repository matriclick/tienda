class CreateNoMoreBookings < ActiveRecord::Migration
  def change
    create_table :no_more_bookings do |t|
      t.integer :service_id
      t.date :date

      t.timestamps
    end
  end
end
