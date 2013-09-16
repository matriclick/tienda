class AddRefundedToShoppingCartItem < ActiveRecord::Migration
  def change
    add_column :shopping_cart_items, :refunded, :boolean
  end
end
