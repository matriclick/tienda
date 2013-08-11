class AddAccountTypeToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :account_type, :string
  end
end
