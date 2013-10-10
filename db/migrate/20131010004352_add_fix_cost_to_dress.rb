class AddFixCostToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :fix_cost, :boolean
  end
end
