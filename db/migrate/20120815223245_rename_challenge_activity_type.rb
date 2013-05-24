class RenameChallengeActivityType < ActiveRecord::Migration
  def up
    rename_table :challenge_activitytypes, :challenge_activity_types
  end

  def down
  end
end
