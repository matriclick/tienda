class AddSocialNetworksToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :facebook, :string
    add_column :supplier_accounts, :twiter, :string
  end
end
