class AddAddressFieldsToSupplierAccount < ActiveRecord::Migration
  def self.up
    add_column :supplier_accounts, :address_region, :string
    add_column :supplier_accounts, :address_commune, :string
  end
 
  def self.down
    remove_column :supplier_accounts, :address_region
    remove_column :supplier_accounts, :address_commune
  end
end
