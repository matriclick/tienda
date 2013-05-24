class RenameColumnGroupIdToInviteeGroupIdOnInvitee < ActiveRecord::Migration
  def up
    rename_column :invitees, :group_id,:invitee_group_id
  end

  def down

  end
end

