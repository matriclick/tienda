class AddSupplierAccountIdToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :supplier_account_id, :integer
  end
end
