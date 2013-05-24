class CreatePurchases < ActiveRecord::Migration
  def change
    drop_table :purchases if table_exists?(:purchases)
    
    create_table :purchases do |t|
      t.integer :purchasable_id
      t.string :purchasable_type
      t.integer :user_id
      t.integer :delivery_info_id
      t.float :price
      t.string :currency

      t.timestamps
    end
  end
end
