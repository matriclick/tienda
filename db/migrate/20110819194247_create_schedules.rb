class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :place_id

      t.timestamps
    end
  end
end
