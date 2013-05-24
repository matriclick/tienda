class AddBudgetInvitationTypeIdToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :budget_invitation_type_id, :integer
  end
end
