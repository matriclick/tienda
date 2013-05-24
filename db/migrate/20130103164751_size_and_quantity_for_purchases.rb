class SizeAndQuantityForPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :size, :string
    add_column :purchases, :quantity, :integer
  end
end
