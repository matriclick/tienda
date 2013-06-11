class AddDeliveryMethodToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :delivery_method, :string
  end
end
