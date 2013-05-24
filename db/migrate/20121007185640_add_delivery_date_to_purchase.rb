class AddDeliveryDateToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :delivery_date, :date
  end
end
