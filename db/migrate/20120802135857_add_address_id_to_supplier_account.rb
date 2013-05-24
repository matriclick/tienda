class AddAddressIdToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :address_id, :integer
  end
end
