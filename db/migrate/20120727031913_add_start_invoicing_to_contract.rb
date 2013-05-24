class AddStartInvoicingToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :start_invoicing, :date
  end
end
