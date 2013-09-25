class AddStorePaidToShoppingCartItem < ActiveRecord::Migration
  def change
    add_column :shopping_cart_items, :store_paid, :boolean
  end
end
