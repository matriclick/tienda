class AddDaysBeforeToActivityReminder < ActiveRecord::Migration
  def change
    add_column :activity_reminders, :days_before, :integer
  end
end
