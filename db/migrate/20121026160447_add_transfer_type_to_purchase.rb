class AddTransferTypeToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :transfer_type, :string
  end
end
