class AddNetMarginToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :net_margin, :float
  end
end
