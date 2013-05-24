class AddPublicUrlToSupplierAccount < ActiveRecord::Migration
  def change
    add_column :supplier_accounts, :public_url, :string
  end
end
