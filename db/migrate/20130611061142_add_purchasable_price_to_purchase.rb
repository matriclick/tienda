class AddPurchasablePriceToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :purchasable_price, :float
  end
end
