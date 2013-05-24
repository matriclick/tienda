class CreateChallengeActivities < ActiveRecord::Migration
  def change
    create_table :challenge_activities do |t|
      t.integer :matriclicker_id
      t.integer :challenge_id
      t.integer :activity_type_id
      t.text :comments

      t.timestamps
    end
  end
end
