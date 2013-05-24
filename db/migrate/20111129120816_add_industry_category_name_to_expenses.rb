class AddIndustryCategoryNameToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :industry_category_name, :string
  end
end
