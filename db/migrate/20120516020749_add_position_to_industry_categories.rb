class AddPositionToIndustryCategories < ActiveRecord::Migration
  def change
    add_column :industry_categories, :position, :integer
  end
end
