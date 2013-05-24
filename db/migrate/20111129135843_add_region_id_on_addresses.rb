class AddRegionIdOnAddresses < ActiveRecord::Migration
  def up
		add_column :addresses, :region_id, :integer
  end

	def down
		remove_column :addresses, :region_id
	end
end
