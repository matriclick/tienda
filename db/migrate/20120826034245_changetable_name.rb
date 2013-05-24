class ChangetableName < ActiveRecord::Migration
  def up
    rename_table :invoices_invoice_months, :invoice_months_invoices
  end

  def down
  end
end
