class CreateAssociationBetweenSaAndUsers < ActiveRecord::Migration
  def up
    create_table :supplier_accounts_users, :id => false do |t|
      t.integer :supplier_account_id
      t.integer :user_id
    end
  end

  def down
  end
end
