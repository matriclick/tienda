class AddIncludedToProductBudgets < ActiveRecord::Migration
  def change
    add_column :product_budgets, :included, :boolean
  end
end
