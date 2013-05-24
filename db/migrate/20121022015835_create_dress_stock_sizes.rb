class CreateDressStockSizes < ActiveRecord::Migration
  def change
    create_table :dress_stock_sizes do |t|
      t.integer :dress_id
      t.integer :size_id
      t.integer :stock

      t.timestamps
    end
  end
end
