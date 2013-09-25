class AddSupplierAccountIdToStorePayment < ActiveRecord::Migration
  def change
    add_column :store_payments, :supplier_account_id, :integer
  end
end
