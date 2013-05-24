class AddIndustryCategoryIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :industry_category_id, :integer
  end
end
