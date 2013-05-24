class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.integer :user_id
      t.boolean :active
      
      t.timestamps
    end
  end
end
