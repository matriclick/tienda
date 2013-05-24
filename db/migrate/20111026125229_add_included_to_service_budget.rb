class AddIncludedToServiceBudget < ActiveRecord::Migration
  def change
    add_column :service_budgets, :included, :boolean
  end
end
