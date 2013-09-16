class AddCountryIdToSupplier < ActiveRecord::Migration
  def change
    add_column(:suppliers, :country_id, :integer) if !Supplier.column_names.include?('country_id')
    add_column(:posts, :country_id, :integer) if !Post.column_names.include?('country_id')
    add_column(:supplier_accounts, :country_id, :integer) if !SupplierAccount.column_names.include?('country_id')
  end
end
