class RenameSupplierIdToSupplierAccountIdOnPresentation < ActiveRecord::Migration
  def change
		rename_column :presentations, :supplier_id, :supplier_account_id
  end
end
