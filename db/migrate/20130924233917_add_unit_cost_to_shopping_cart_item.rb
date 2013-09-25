class AddUnitCostToShoppingCartItem < ActiveRecord::Migration
  def change
    add_column :shopping_cart_items, :unit_cost, :integer
  end
end
