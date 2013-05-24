class SizeAndQuantityForShoppingCartItems < ActiveRecord::Migration
  def change
    add_column :shopping_cart_items, :size, :string
    add_column :shopping_cart_items, :quantity, :integer
  end
end
