class ChangePricesToServices < ActiveRecord::Migration
  def up
  	change_column :services, :price, :decimal, :precision => 10, :scale => 0, :default => 0
  	change_column :services, :top_price_range, :decimal, :precision => 10, :scale => 0, :default => 0
  end

  def down
  	change_column :services, :price, :integer, :precision => 10, :scale => 0, :default => 0
  	change_column :services, :top_price_range, :integer, :precision => 10, :scale => 0, :default => 0
  end
end
