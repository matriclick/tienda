class RenameSupplierAppoveForSupplierAccount < ActiveRecord::Migration
  def change
		rename_column :supplier_accounts, :approved, :approved_by_us
		rename_column :supplier_accounts, :supplier_approve, :approved_by_supplier
  end
end
