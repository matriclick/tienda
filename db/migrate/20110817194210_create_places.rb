class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
   	  t.integer :supplier_account_id
      t.integer :max_capacity
      t.string :address
      t.string :contact_phone
      t.decimal :rent_cost
      t.string :commune
      t.float :latitude
      t.float :longitude      

      t.timestamps
    end
  end
end
