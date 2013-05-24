class ChangeColumnTypeForContracts < ActiveRecord::Migration
  def up
    rename_column :contracts, :contract_type, :contract_type_id
    change_column :contracts, :contract_type_id, :integer
  end

  def down
  end
end
