class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.integer :industry_category_id
      t.string :name

      t.timestamps
    end
  end
end
