class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :lastname_p
      t.string :lastname_m
      t.string :rut
      t.string :email
      t.integer :user_account_id

      t.timestamps
    end
  end
end
