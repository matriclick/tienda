class AddSupplierApproveToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :supplier_approve, :boolean
  end
end
