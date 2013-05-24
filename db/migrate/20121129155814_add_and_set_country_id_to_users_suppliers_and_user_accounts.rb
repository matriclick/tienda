class AddAndSetCountryIdToUsersSuppliersAndUserAccounts < ActiveRecord::Migration
  def change
    chile = Country.find_by_url_path('chile')
    peru = Country.find_by_url_path('peru')
    if !chile.nil? and !peru.nil?
      add_column :users, :country_id, :integer, :default => chile.id
      add_column :suppliers, :country_id, :integer, :default => chile.id
      add_column :user_accounts, :country_id, :integer, :default => chile.id
    end
  end
end
