class ChangePhoneNumbersToStringToSupplierAccountAndSupplierContacts < ActiveRecord::Migration
  def up
		change_column :supplier_accounts, :phone_number, :string
		change_column :supplier_contacts, :phone_number, :string
  end

  def down
		change_column :supplier_accounts, :phone_number, :integer
		change_column :supplier_contacts, :phone_number, :integer
  end
end
