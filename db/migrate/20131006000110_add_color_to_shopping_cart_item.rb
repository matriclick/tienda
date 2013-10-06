class AddColorToShoppingCartItem < ActiveRecord::Migration
  def change
    add_column :shopping_cart_items, :color, :string
  end
end
