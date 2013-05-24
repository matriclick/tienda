class RemoveRegionFromAddresses < ActiveRecord::Migration
  def up
		remove_column :addresses, :region
  end

  def down
		add_column :addresses, :region, :string
  end
end
