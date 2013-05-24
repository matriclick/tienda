class RemoveRelationBetweenAdressAndUser < ActiveRecord::Migration
  def up
    drop_table :users_addresses
  end

  def down
  end
end
