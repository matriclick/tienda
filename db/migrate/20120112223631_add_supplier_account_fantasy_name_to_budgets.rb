class AddSupplierAccountFantasyNameToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :supplier_account_fantasy_name, :string
  end
end
