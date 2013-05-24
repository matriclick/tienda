class RenamePlacesIdToServicesIdOnEvents < ActiveRecord::Migration
  def up
    rename_column :events,:place_id,:service_id
  end

  def down
  end
end
