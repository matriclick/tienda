class AddDidReviewToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :did_review, :boolean, :default => false
  end
end
