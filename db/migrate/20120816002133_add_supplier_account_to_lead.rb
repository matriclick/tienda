class AddSupplierAccountToLead < ActiveRecord::Migration
  def change
    add_column :leads, :supplier_account_id, :integer
  end
end
