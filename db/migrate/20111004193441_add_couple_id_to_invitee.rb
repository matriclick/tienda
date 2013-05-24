class AddCoupleIdToInvitee < ActiveRecord::Migration
  def change
     add_column :invitees,:couple_id,:integer
  end
end

