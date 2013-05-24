class AddCommuneIdOnAddresses < ActiveRecord::Migration
   def up
		add_column :addresses, :commune_id, :integer
  end

	def down
		remove_column :addresses, :commune_id
	end
end
