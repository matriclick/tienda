class AddCustomMessageToImportantDates < ActiveRecord::Migration
  def change
    add_column :important_dates, :custom_message, :string
  end
end
