class IndustryCategoriesInternacionalization < ActiveRecord::Migration
  def change
    create_table :countries_industry_categories, :id => false do |t|
      t.integer :country_id
      t.integer :industry_category_id
    end
    create_table :countries_sub_industry_categories, :id => false do |t|
      t.integer :country_id
      t.integer :sub_industry_category_id
    end
  end
end
