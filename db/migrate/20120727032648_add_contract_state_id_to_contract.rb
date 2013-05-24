class AddContractStateIdToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :contract_state_id, :integer
  end
end
