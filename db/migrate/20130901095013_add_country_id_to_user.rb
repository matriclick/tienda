class AddCountryIdToUser < ActiveRecord::Migration
  def change
    add_column(:users, :country_id, :integer) if !User.column_names.include?('country_id')
    add_column(:user_accounts, :country_id, :integer) if !UserAccount.column_names.include?('country_id')
  end
end