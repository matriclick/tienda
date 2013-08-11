class AddAccountBankToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :account_bank, :string
  end
end
