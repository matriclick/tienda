class AddCommuneIdToSubscriber < ActiveRecord::Migration
  def change
    add_column :subscribers, :commune_id, :integer
  end
end
