class CreateReservedDates < ActiveRecord::Migration
  def change
    unless ReservedDate.table_exists?
      create_table :reserved_dates do |t|
        t.date :date
        t.integer :supplier_account_id
        t.text :comment

        t.timestamps
      end
    end
  end
end
