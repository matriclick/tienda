class AddFieldsToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :collection_mail_sent, :boolean
    add_column :invoices, :date_collection_mail_sent, :date
  end
end
