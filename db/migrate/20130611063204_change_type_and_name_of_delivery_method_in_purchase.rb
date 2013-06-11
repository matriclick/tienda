class ChangeTypeAndNameOfDeliveryMethodInPurchase < ActiveRecord::Migration
  def up
    rename_column :purchases, :delivery_method, :delivery_method_id
    change_column :purchases, :delivery_method_id, :integer
  end

  def down
    rename_column :purchases, :delivery_method_id, :delivery_method
    change_column :purchases, :delivery_method, :string
  end
end
