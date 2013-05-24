class CreateScheduleDayTypes < ActiveRecord::Migration
  def change
    create_table :schedule_day_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
