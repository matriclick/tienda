class AddIndustryCategoryIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :industry_category_id, :integer
  end
end
