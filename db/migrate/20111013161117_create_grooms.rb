class CreateGrooms < ActiveRecord::Migration
  def change
    create_table :grooms do |t|
      t.string :name
      t.string :lastname_p
      t.string :lastname_m
      t.string :rut
      t.date :born_date
      t.string :email
      t.string :city
      t.string :commune
      t.string :country
      t.string :phone
      t.string :cell_phone
      t.string :profession
      t.integer :user_account_id

      t.timestamps
    end
  end
end
