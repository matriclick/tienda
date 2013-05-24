class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :purchase_id
      t.integer :user_id
      t.integer :value
      t.boolean :active
      t.text :formula
      t.date :expiration_date

      t.timestamps
    end
  end
end
