class RenameInviteestatusToStatusOnInvitee < ActiveRecord::Migration
  def up
    rename_column :invitees, :inviteestatus_id,:status_id
  end

  def down
    rename_column :invitees, :status_id,:inviteestatus_id
  end
end

