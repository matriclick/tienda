class RemoveIncludedFromServiceBudgets < ActiveRecord::Migration
  def up
    remove_column :service_budgets, :included
  end

  def down
    add_column :service_budgets, :included, :boolean
  end
end
