class AddDateNameToImportantDates < ActiveRecord::Migration
  def change
    add_column :important_dates, :date_name, :string
  end
  def self.down
    remove_column :important_dates, :date_name, :string
  end
end
