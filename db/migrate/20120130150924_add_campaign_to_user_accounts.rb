class AddCampaignToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :in_campaign, :boolean, :default => false
  end
end
