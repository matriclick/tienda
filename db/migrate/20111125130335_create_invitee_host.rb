class CreateInviteeHost < ActiveRecord::Migration
  def change
    create_table :invitee_hosts do |t|
			t.string :name      
			
      t.timestamps
    end
	end
end
