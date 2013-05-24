class CreateCeremonyDayHours < ActiveRecord::Migration
  def change
    create_table :ceremony_day_hours do |t|
      t.integer :ceremony_day_id
      t.time :hour

      t.timestamps
    end
  end
end
