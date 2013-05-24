class AddBookingResources < ActiveRecord::Migration
  def change
		add_column :supplier_accounts, :booking_resources, :integer, :default => 3
		add_column :supplier_accounts, :booking_waiting_list_size, :integer, :default => 5
		add_column :products, :booking_resources_consumed, :integer, :default => 1
		add_column :services, :booking_resources_consumed, :integer, :default => 1
  end
end
