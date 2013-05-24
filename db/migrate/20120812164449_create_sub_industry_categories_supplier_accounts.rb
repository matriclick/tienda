class CreateSubIndustryCategoriesSupplierAccounts < ActiveRecord::Migration
  def change
    create_table :sub_industry_categories_supplier_accounts do |t|
      t.integer :sub_industry_category_id
      t.integer :supplier_account_id

      t.timestamps
    end
  end
end
