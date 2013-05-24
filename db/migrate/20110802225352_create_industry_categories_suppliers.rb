class CreateIndustryCategoriesSuppliers < ActiveRecord::Migration
  def up
		create_table :industry_categories_suppliers, :id => false do |t|
			t.integer :industry_category_id
			t.integer :supplier_id
			
			t.timestamps
		end
  end

  def down
		drop_table :industry_categories_suppliers
  end
end
