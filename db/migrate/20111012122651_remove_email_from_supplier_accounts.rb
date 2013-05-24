class RemoveEmailFromSupplierAccounts < ActiveRecord::Migration
	def up
		remove_column :supplier_accounts, :email
  end

  def down
		add_column :supplier_accounts, :email, :string
  end
end
