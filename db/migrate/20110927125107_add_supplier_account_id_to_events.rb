class AddSupplierAccountIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :supplier_account_id, :integer
  end
end
