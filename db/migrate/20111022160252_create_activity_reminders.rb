class CreateActivityReminders < ActiveRecord::Migration
  def change
    create_table :activity_reminders do |t|
      t.string :name
      t.string :mail
      t.integer :activity_id

      t.timestamps
    end
  end
end
