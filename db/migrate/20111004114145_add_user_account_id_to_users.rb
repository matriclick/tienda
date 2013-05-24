class AddUserAccountIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_account_id, :integer
  end
end
