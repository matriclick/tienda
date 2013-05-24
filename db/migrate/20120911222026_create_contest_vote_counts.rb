class CreateContestVoteCounts < ActiveRecord::Migration
  def change
    create_table :contest_vote_counts do |t|
      t.integer :vote_count
      t.integer :supplier_account_id
      t.integer :matri_dream_ic_id

      t.timestamps
    end
  end
end
