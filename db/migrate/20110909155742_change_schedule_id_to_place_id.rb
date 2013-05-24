class ChangeScheduleIdToPlaceId < ActiveRecord::Migration
  def up
    remove_column :important_dates, :schedule_id
    add_column :important_dates, :place_id, :integer
  end

  def down
    add_column :important_dates, :schedule_id, :integer
    remove_column :important_dates, :place_id
  end
end
