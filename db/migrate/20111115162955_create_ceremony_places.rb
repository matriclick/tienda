class CreateCeremonyPlaces < ActiveRecord::Migration
  def change
    create_table :ceremony_places do |t|
      t.integer :address_id
      t.string :phone_number
      t.string :contact_email
      t.string :contact_person
      t.string :schedule
      t.integer :capacity
      t.text :additional_information
      t.decimal :price
      t.decimal :top_price_range

      t.timestamps
    end
  end
end
