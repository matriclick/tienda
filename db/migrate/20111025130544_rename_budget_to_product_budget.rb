class RenameBudgetToProductBudget < ActiveRecord::Migration
  def up
  	rename_table :budgets, :product_budgets
  end

  def down
  	rename_table :product_budgets, :budgets
  end
end
