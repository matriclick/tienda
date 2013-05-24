class FixAddressColumnName < ActiveRecord::Migration

  def self.up
    rename_column :supplier_accounts, :address, :addressf
  end

  def self.down
    rename_column :supplier_accounts, :addressf, :address
  end

end
