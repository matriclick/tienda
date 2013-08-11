class AddFundsReceivedToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :funds_received, :boolean
  end
end
