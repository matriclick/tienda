class AddAddressIdToGroomsAndBrides < ActiveRecord::Migration
  def change
		add_column :grooms, :address_id, :integer
		add_column :brides, :address_id, :integer
  end
end
