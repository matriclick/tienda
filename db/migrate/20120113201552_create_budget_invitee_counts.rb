class CreateBudgetInviteeCounts < ActiveRecord::Migration
  def change
    create_table :budget_invitee_counts do |t|
      t.integer :count
      t.integer :budget_type_id
      t.integer :user_account_id
			t.integer :budget_invitation_type_id
      t.timestamps
    end
  end
end
