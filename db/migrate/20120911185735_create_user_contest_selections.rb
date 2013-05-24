class CreateUserContestSelections < ActiveRecord::Migration
  def change
    create_table :user_contest_selections do |t|
      t.integer :user_id
      t.integer :supplier_account_id
      t.integer :matri_dream_ic_id

      t.timestamps
    end
  end
end
