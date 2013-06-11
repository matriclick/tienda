class AddDeliveryMethodCostToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :delivery_method_cost, :float
  end
end
