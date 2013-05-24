class AddScheduleDayTypeIdToScheduleDay < ActiveRecord::Migration
  def change
    add_column :schedule_days, :schedule_day_type_id, :integer
  end
end
