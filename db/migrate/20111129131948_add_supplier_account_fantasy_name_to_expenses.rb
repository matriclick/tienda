class AddSupplierAccountFantasyNameToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :supplier_account_fantasy_name, :string
  end
end
