class RenamePlacesIdToServicesIdOnImportantDates < ActiveRecord::Migration
  def up
    rename_column :important_dates,:place_id,:service_id
  end

  def down
  end
end
