class AddRefundedToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :refunded, :boolean
  end
end
