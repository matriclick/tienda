class CreateDefaultInviteeGroupsTable < ActiveRecord::Migration
   def change
    create_table :default_invitee_groups do |t|
      t.string :name   

      t.timestamps
    end
  end
end
