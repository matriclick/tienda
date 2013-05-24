class AddApprovedToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :approved, :boolean
  end
end
