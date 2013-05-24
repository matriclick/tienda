class AddUserIdToDeliveryInfos < ActiveRecord::Migration
  def change
    add_column :delivery_infos, :user_id, :integer
  end
end
