class CreateContestVotes < ActiveRecord::Migration
  def change
    create_table :contest_votes do |t|
      t.integer :user_id
      t.integer :contestant_id
      t.integer :contest_id

      t.timestamps
    end
  end
end
