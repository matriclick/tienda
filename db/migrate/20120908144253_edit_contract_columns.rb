class EditContractColumns < ActiveRecord::Migration
  def up
    rename_column :contracts, :includes_tax, :vat_free
    add_column :contracts, :invoice_mailing, :text
  end

  def down
  end
end
