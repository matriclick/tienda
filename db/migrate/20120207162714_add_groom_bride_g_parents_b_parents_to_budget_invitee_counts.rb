class AddGroomBrideGParentsBParentsToBudgetInviteeCounts < ActiveRecord::Migration
  def up
		remove_column :budget_invitee_counts, :budget_type_id
		remove_column :budget_invitee_counts, :count
    add_column :budget_invitee_counts, :groom, :integer, :default => 100
    add_column :budget_invitee_counts, :bride, :integer, :default => 100
    add_column :budget_invitee_counts, :g_parents, :integer, :default => 100
    add_column :budget_invitee_counts, :b_parents, :integer, :default => 100
  end

	def down
		add_column :budget_invitee_counts, :budget_type_id, :integer
		add_column :budget_invitee_counts, :count, :integer, :default => 250
    remove_column :budget_invitee_counts, :groom
    remove_column :budget_invitee_counts, :bride
    remove_column :budget_invitee_counts, :g_parents
    remove_column :budget_invitee_counts, :b_parents
	end
end
