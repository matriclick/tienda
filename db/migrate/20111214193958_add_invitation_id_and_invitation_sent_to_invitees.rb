class AddInvitationIdAndInvitationSentToInvitees < ActiveRecord::Migration
  def change
		add_column :invitees, :invitation_id, :integer
		add_column :invitees, :invitation_sent, :bool
  end
end
