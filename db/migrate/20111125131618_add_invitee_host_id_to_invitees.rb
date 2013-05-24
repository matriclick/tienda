class AddInviteeHostIdToInvitees < ActiveRecord::Migration
  def change
		add_column :invitees, :invitee_host_id, :integer
  end
end
