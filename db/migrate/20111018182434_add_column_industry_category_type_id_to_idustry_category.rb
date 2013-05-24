class AddColumnIndustryCategoryTypeIdToIdustryCategory < ActiveRecord::Migration
  def change
    add_column :industry_categories, :industry_category_type_id, :integer
  end
end
