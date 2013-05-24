class CreateSubIndustryCategories < ActiveRecord::Migration
  def change
    create_table :sub_industry_categories do |t|
      t.integer :industry_category_id
      t.string :name
      t.text :description
      t.integer :position

      t.timestamps
    end
  end
end
