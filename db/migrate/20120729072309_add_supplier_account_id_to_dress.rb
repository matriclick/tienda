class AddSupplierAccountIdToDress < ActiveRecord::Migration
  def change
    add_column :dresses, :supplier_account_id, :integer
  end
end
