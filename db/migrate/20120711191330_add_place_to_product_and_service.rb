class AddPlaceToProductAndService < ActiveRecord::Migration
  def self.up
    add_column :products, :place, :integer
    add_column :services, :place, :integer
  end

  def self.down
    remove_column :products, :place, :integer
    remove_column :services, :place, :integer
  end
end
