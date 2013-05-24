class CreateInviteeRoles < ActiveRecord::Migration
  def change
    create_table :invitee_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
