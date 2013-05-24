class CreateServiceBudgets < ActiveRecord::Migration
  def change
    create_table :service_budgets do |t|
      t.integer :user_account_id
      t.integer :service_id
      t.integer :budget_type_id

      t.timestamps
    end
  end
end
