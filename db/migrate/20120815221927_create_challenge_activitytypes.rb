class CreateChallengeActivitytypes < ActiveRecord::Migration
  def change
    create_table :challenge_activitytypes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
