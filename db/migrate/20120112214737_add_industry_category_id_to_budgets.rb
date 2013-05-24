class AddIndustryCategoryIdToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :industry_category_id, :integer
  end
end
