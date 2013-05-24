class RenameSupplierIdToSupplierAccountIdOnIndustryCategoriesSupplierAccounts < ActiveRecord::Migration
  def change
		rename_column :industry_categories_supplier_accounts, :supplier_id, :supplier_account_id
  end
end
