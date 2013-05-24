class CreateIndustryCategoryTypes < ActiveRecord::Migration
  def change
    create_table :industry_category_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
