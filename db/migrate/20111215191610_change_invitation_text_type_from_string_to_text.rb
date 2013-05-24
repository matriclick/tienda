class ChangeInvitationTextTypeFromStringToText < ActiveRecord::Migration
  def change
		change_column :invitations, :text, :text
	end
end
