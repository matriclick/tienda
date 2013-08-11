class AddAccountOwnerEmailToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :account_owner_email, :string
  end
end
