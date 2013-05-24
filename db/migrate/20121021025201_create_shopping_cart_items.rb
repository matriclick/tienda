class CreateShoppingCartItems < ActiveRecord::Migration
  def change
    create_table :shopping_cart_items do |t|
      t.integer :shopping_cart_id
      t.integer :purchasable_id
      t.string :purchasable_type

      t.timestamps
    end
  end
  
  def down
    drop_table :shopping_cart_items if table_exists?(:shopping_cart_items)
  end
end
