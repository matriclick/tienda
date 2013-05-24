class RemoveIncludedFromProductBudgets < ActiveRecord::Migration
  def up
    remove_column :product_budgets, :included
  end

  def down
    add_column :product_budgets, :included, :boolean
  end
end
