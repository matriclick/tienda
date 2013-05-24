class AddConversableTypeConversableIdToConversations < ActiveRecord::Migration
  def up
    add_column :conversations, :conversable_type, :string
    add_column :conversations, :conversable_id, :integer
		remove_column :conversations, :product_id
		remove_column :conversations, :service_id
  end

	def down
		add_column :conversations, :product_id, :integer
		add_column :conversations, :service_id, :integer
		remove_column :conversations, :conversable_type
		remove_column :converstaions, :conversable_id
	end
end
