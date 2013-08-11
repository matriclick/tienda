class AddVatCostToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :vat_cost, :float
  end
end
