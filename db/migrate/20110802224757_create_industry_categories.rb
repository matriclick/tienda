class CreateIndustryCategories < ActiveRecord::Migration
  def change
    create_table :industry_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
