class DestroyUnusedTable < ActiveRecord::Migration
  def up
    drop_table :dresses_users
  end

  def down
  end
end
