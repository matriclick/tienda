class CreateInviteeGroups < ActiveRecord::Migration
  def change
    create_table :invitee_groups do |t|

      t.integer :user_account_id

      t.timestamps
    end
  end
end

