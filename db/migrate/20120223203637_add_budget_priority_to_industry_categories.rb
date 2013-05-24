class AddBudgetPriorityToIndustryCategories < ActiveRecord::Migration
  def change
    add_column :industry_categories, :budget_priority, :integer
  end
end
