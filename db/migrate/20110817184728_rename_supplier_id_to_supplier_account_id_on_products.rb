class RenameSupplierIdToSupplierAccountIdOnProducts < ActiveRecord::Migration
  def change
		rename_column :products, :supplier_id, :supplier_account_id
  end
end
