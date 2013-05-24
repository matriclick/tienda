class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
			t.integer :user_account_id
      t.integer :supplier_account_id
      t.integer :product_id
      t.integer :service_id
      t.integer :price
      t.string :price_description
      t.integer :quantity
      t.decimal :payed_percentage

      t.timestamps
    end
  end
end
