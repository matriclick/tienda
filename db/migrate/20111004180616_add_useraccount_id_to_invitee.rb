class AddUseraccountIdToInvitee < ActiveRecord::Migration
  def change
    add_column :invitees,:user_account_id,:integer
  end
end

