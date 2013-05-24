class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :status
      t.string :bookable_type
      t.integer :bookable_id
      t.integer :user_account_id
     	t.integer :supplier_account_id
      t.text :message
      t.string :read
			t.date :date

      t.timestamps
    end
  end
end
