class CreateStorePayments < ActiveRecord::Migration
  def change
    create_table :store_payments do |t|
      t.integer :amount
      t.text :comments

      t.timestamps
    end
  end
end
