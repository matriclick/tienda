class AddLatitudLongitudToDeliveryInfo < ActiveRecord::Migration
  def change
    add_column :delivery_infos, :latitude, :float
    add_column :delivery_infos, :longitude, :float
  end
end
