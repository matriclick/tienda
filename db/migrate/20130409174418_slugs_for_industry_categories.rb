class SlugsForIndustryCategories < ActiveRecord::Migration
  def up
    add_column :industry_categories, :slug, :string
    add_index :industry_categories, :slug, unique: true
    
    IndustryCategory.find_each(&:save)
  end

  def down
  end
end
