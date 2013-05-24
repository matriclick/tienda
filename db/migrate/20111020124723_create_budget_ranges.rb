class CreateBudgetRanges < ActiveRecord::Migration
  def change
    create_table :budget_ranges do |t|
      t.string :range

      t.timestamps
    end
  end
end
