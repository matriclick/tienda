class CreateTentativeBudgets < ActiveRecord::Migration
  def change
    create_table :tentative_budgets do |t|
      t.integer :budget_range_id
      t.integer :user_account_id

      t.timestamps
    end
  end
end
