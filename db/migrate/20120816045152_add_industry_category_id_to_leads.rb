class AddIndustryCategoryIdToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :industry_category_id, :integer
  end
end
