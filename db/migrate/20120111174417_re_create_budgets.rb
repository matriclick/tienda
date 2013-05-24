class ReCreateBudgets < ActiveRecord::Migration
  def change
		create_table :budgets do |t|
			t.integer :user_account_id
			t.string :budgetable_type
			t.integer :budgetable_id
			t.integer :budget_type_id
			
			t.timestamps
		end
  end
end
