class AddFieldsToScheduleDay < ActiveRecord::Migration
  def change
    add_column :schedule_days, :start_lunch_time, :time
    add_column :schedule_days, :end_lunch_time, :time
  end
end
