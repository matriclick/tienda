class AddInviteesQuantityToUserAccount < ActiveRecord::Migration
  def change
    add_column :user_accounts, :invitees_quantity, :integer
  end
end
