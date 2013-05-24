class CreateImportantDates < ActiveRecord::Migration
  def change
    create_table :important_dates do |t|
      t.integer :schedule_id
      t.datetime :date

      t.timestamps
    end
  end
end
