class AddTotalCostToShoppingCartItem < ActiveRecord::Migration
  def change
    add_column :shopping_cart_items, :total_cost, :float
  end
end
