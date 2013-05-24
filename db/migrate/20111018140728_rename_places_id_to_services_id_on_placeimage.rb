class RenamePlacesIdToServicesIdOnPlaceimage < ActiveRecord::Migration
  def up
    rename_column :service_images,:place_id,:service_id
  end

  def down
  end
end
