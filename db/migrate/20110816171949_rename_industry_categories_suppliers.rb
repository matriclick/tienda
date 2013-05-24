class RenameIndustryCategoriesSuppliers < ActiveRecord::Migration
  def change
		rename_table :industry_categories_suppliers, :industry_categories_supplier_accounts
  end
end
