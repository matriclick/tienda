class AddContractFields < ActiveRecord::Migration
  def self.up
    add_column :contracts, :end_contract_date, :date
    add_column :contracts, :invoice_from, :date
    add_column :contracts, :read_comments_before_invoice, :boolean
    add_column :contracts, :includes_tax, :boolean
    add_column :contracts, :quotas, :integer
    rename_column :contracts, :not_invoice_until, :invoice_to
    remove_column :contracts, :length
  end
 
  def self.down
    remove_column :contracts, :end_contract_date, :date
    remove_column :contracts, :invoice_from, :date
    remove_column :contracts, :read_comments_before_invoice, :boolean
    remove_column :contracts, :includes_tax, :boolean
    remove_column :payment_, :quotas, :integer
    rename_column :contracts, :invoice_to, :not_invoice_until
    add_column :contracts, :length, :integer
  end
  
end
