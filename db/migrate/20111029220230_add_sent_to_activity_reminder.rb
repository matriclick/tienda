class AddSentToActivityReminder < ActiveRecord::Migration
  def change
    add_column :activity_reminders, :sent, :boolean
  end
end
