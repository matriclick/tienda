class AddAccountNumberToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :account_number, :string
  end
end
