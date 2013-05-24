class AddIndustryCategoryIdToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :industry_category_id, :integer
  end
end
