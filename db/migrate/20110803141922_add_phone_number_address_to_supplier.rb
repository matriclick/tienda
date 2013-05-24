class AddPhoneNumberAddressToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :phone_number, :integer
    add_column :suppliers, :address, :string
  end
end
