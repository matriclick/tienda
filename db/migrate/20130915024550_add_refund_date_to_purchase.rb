class AddRefundDateToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :refund_date, :date
  end
end
