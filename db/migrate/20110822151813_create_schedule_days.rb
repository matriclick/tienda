class CreateScheduleDays < ActiveRecord::Migration
  def change
    create_table :schedule_days do |t|
      t.integer :day_id
      t.integer :schedule_id
      t.time :from
      t.time :to
      t.boolean :enabled
      t.boolean :all_day

      t.timestamps
    end
  end
end
