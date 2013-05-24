class RemoveServiceIdToImportantDates < ActiveRecord::Migration
  def up
  	remove_column :important_dates, :service_id
  	add_column :important_dates, :supplier_account_id, :integer
  end

  def down
  	add_column :important_dates, :service_id, :integer
  	remove_column :important_dates, :supplier_account
  end
end
