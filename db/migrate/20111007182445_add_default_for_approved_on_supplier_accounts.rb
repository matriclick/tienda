class AddDefaultForApprovedOnSupplierAccounts < ActiveRecord::Migration
  def change
		change_column :supplier_accounts, :approved_by_us, :boolean, :default => false
		change_column :supplier_accounts, :approved_by_supplier, :boolean, :default => false
  end
end
