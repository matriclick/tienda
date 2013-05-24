class AddFieldsToImportantDates < ActiveRecord::Migration
  def change
    add_column :important_dates, :ends_date, :datetime
    add_column :important_dates, :locked, :boolean
  end
end
