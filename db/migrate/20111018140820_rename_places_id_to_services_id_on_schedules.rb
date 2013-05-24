class RenamePlacesIdToServicesIdOnSchedules < ActiveRecord::Migration
  def up
    rename_column :schedules,:place_id,:service_id
  end

  def down
  end
end
