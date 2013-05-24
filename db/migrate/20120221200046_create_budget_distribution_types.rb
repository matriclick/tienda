class CreateBudgetDistributionTypes < ActiveRecord::Migration
  def change
    create_table :budget_distribution_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
