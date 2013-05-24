class ChangeUserAccountIdToReferenceRequest < ActiveRecord::Migration
  def up
  	rename_column :reference_requests, :user_account_id, :user_id
  end

  def down
  	rename_column :reference_requests, :user_id, :user_account_id
  end
end
