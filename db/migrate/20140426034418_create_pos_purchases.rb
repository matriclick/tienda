class CreatePosPurchases < ActiveRecord::Migration
  def change
    create_table :pos_purchases do |t|
      t.integer :user_id
      t.string :email_buyer
      t.string :payment_method
      t.integer :shopping_cart_id
      t.integer :price
      t.string :currency
      t.integer :supplier_account_id

      t.timestamps
    end
  end
end
