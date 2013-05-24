class ChangeContratRelationToLead < ActiveRecord::Migration
  def up
    rename_column :contracts, :supplier_account_id, :lead_id
  end

  def down
  end
end
