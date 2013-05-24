class CreateBudgetSlots < ActiveRecord::Migration
  def change
    create_table :budget_slots do |t|
      t.integer :industry_category_id
      t.integer :budget_distribution_type_id
			t.integer :user_account_id
			t.integer :budget_type_id

      t.timestamps
    end
  end
end
