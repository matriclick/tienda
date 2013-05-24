class RenameSupplierIdToSupplierAccountIdInSupplierContacts < ActiveRecord::Migration
  def change
		rename_column :supplier_contacts, :supplier_id, :supplier_account_id
  end
end
