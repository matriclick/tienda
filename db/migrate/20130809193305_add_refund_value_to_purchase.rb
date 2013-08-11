class AddRefundValueToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :refund_value, :float
  end
end
