class RenameColumnForChallengeActivities < ActiveRecord::Migration
  def up
    rename_column :challenge_activities, :activity_type_id, :challenge_activity_type_id
  end

  def down
  end
end
