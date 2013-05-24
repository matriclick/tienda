class AddNameToInviteeGroup < ActiveRecord::Migration
  def change
    add_column :invitee_groups,:name,:string
  end
end

