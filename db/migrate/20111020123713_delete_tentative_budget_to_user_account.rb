class DeleteTentativeBudgetToUserAccount < ActiveRecord::Migration
  def up
  	remove_column :user_accounts, :tentative_budget
  end

  def down
  	remove_column :user_accounts, :tentative_budget, :integer
  end
end
