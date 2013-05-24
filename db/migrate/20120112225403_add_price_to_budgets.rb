class AddPriceToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :price, :integer
  end
end
