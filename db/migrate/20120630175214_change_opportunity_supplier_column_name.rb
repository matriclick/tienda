class ChangeOpportunitySupplierColumnName < ActiveRecord::Migration
  def up
    rename_column :opportunities, :supplier_id, :supplier_account_id
  end

  def down
  end
end
