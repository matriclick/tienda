class AddSupplierAccountTypeIdToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :supplier_account_type_id, :integer
  end
end
