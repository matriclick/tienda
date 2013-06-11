class RenameDispatchCostToDeliveryCost < ActiveRecord::Migration
  def up
    rename_column :purchases, :dispatch_cost, :delivery_cost
  end

  def down
    rename_column :purchases, :delivery_cost, :dispatch_cost
  end
end
