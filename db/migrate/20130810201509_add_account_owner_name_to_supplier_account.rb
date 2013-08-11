class AddAccountOwnerNameToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :account_owner_name, :string
  end
end
