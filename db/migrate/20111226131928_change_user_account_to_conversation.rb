class ChangeUserAccountToConversation < ActiveRecord::Migration
  def up
  	rename_column :conversations, :user_account_id, :user_id
  end

  def down
  	rename_column :conversations, :user_id, :user_account_id
  end
end
