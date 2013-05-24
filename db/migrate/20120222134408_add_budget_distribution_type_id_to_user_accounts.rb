class AddBudgetDistributionTypeIdToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :budget_distribution_type_id, :integer
  end
end
