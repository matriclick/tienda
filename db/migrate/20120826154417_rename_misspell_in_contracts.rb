class RenameMisspellInContracts < ActiveRecord::Migration
  def up
    rename_column :contracts, :commision, :commission
  end

  def down
  end
end
