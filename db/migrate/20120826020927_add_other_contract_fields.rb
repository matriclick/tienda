class AddOtherContractFields < ActiveRecord::Migration
  def up
    add_column :contracts, :start_contract_date, :date
  end

  def down
    remove_column :contracts, :start_contract_date
  end
end
