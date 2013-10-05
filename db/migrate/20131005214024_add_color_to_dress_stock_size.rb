class AddColorToDressStockSize < ActiveRecord::Migration
  def change
    add_column :dress_stock_sizes, :color, :string
  end
end
