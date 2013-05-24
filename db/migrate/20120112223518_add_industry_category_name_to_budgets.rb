class AddIndustryCategoryNameToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :industry_category_name, :string
  end
end
