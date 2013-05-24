class CreateBudgetInvitationTypes < ActiveRecord::Migration
  def change
    create_table :budget_invitation_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
