class AddActualDeliveryCostToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :actual_delivery_cost, :float
  end
end
