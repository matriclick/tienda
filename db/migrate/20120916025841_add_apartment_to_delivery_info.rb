class AddApartmentToDeliveryInfo < ActiveRecord::Migration
  def change
    add_column :delivery_infos, :apartment, :string
  end
end
