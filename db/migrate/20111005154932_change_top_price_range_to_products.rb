class ChangeTopPriceRangeToProducts < ActiveRecord::Migration
  def up
    remove_column :products, :top_price_range
    add_column :products, :top_price_range, :decimal, :default => 0
  end

  def down
    remove_column :products, :top_price_range
    add_column :products, :top_price_range, :integer
  end
end
