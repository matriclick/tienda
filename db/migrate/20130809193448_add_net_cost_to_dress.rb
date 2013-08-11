class AddNetCostToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :net_cost, :float
  end
end
