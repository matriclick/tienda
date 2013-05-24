class AddIndustryCategoryIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :industry_category_id, :integer
  end
end
