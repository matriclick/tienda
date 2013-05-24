class AddInvoiceFields < ActiveRecord::Migration
  def up
    rename_column :invoices, :payed, :paid
  end

  def down
  end
end
