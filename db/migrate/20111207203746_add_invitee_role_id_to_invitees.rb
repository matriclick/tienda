class AddInviteeRoleIdToInvitees < ActiveRecord::Migration
  def change
		add_column :invitees, :invitee_role_id, :integer
  end
end
