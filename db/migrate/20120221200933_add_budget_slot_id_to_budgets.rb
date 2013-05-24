class AddBudgetSlotIdToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :budget_slot_id, :integer
  end
end
