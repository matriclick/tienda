class AddGroupIdToInvitee < ActiveRecord::Migration
  def change
    add_column :invitees,:group_id,:integer
  end
end

